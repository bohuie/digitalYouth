# --------------- Imports ---------------
from lxml import html
from lxml.html.clean import clean_html
import nltk.data
import requests
import os
import re
import sys
import time
from lxml import etree
# --------------- Functions ---------------

# Extracts data from the html file and returns array of data
def extract_data(file):
	try:
		tree = html.fromstring(open(file, "r").read())
		logo = tree.xpath('//a[@class="job-view-company-logo-link"]/img/@src')
		company_name = tree.xpath('//span[@data-automation="job-company"]')[0].text.title()
		title = tree.xpath('//*[@data-automation="job-title"]')[0].text
		loc_arr = tree.xpath('//*[@data-automation="job-Location"]')[0].text.title().split(',')
		location = loc_arr[0] + "," + loc_arr[1].upper() #Converts location string to city, Province code
		link = tree.xpath('//*[@class="page-link"]/@href')[0]
		category = tree.xpath('//a[@class="job-view-header-link link"]')[0].text.title()
		job_type_elem = tree.xpath('//section[@class="job-summary"]//li[./span[@class="sidebar-content-heading job-position-label"]]//span[@class="sidebar-sub-item"]')
		
		#--- Extract job type --- 
		if len(job_type_elem) > 0:
			if len(job_type_elem) > 1:
				job_type = job_type_elem[1].text
			else:
				job_type = job_type_elem[0].text
		else:
			job_type = None
			
		
		closing = ""
		req_skills = []
		pref_skills = []
		req_skills_raw = []
		pref_skills_raw = []
		desc = []

		#--- Strings to filter by ---
		skills_strings = ['qualif','skill','abil,','able','capab','experi','criter','knowl','educ','expertise']
		prefer_strings = ['prefer','good','nice','bonus','addit']
		benefits_strings = ['benefit']
		roles_strings = ['role']

		tags = tree.xpath('//section[@class="job-view-content-wrapper js-job-view-header-apply"]/*')
		for p in tags:
			ptext = "\n ".join(p.itertext())
			if any(substr in ptext.lower() for substr in benefits_strings) or any(substr in ptext.lower() for substr in roles_strings):
				next
			if any(substr in ptext.lower() for substr in skills_strings) and len(ptext) < 50:
				sibling = get_silbing_ul(p.getnext())
				if sibling is not None:
					children = sibling.getchildren()
					for c in children:
						if any(substr in ptext.lower() for substr in prefer_strings):
							pref_skills_raw.append(c.text)
							pref_skills = add_skills(c.text,pref_skills)
						else:
							req_skills_raw.append(c.text)
							req_skills = add_skills(c.text,req_skills)

			elif "clos" in ptext.lower() and "date" in ptext.lower() and len(ptext) < 80:
				closing = ptext.split(':')[1].strip()

			elif len(ptext) > 5: # Add to description string
				desc.append(check_string(ptext))

		desc = '\n '.join(desc)
		for r in req_skills_raw:
			if r is not None:
				desc = ireplace(r, "", desc)
		for p in pref_skills_raw:
			if p is not None:
				desc = ireplace(p, "", desc)

		if (req_skills == [] and pref_skills == []) or desc == "":
			return None
	except (IndexError, etree.XMLSyntaxError):
		return None

	company_name = check_string(company_name)
	title = check_string(title)
	location = check_string(location)
	closing = check_string(closing)
	desc = check_string(desc)
	category = check_string(category)
	return [category,closing,company_name,desc,link,location,logo,title,req_skills,pref_skills,job_type]

# Processes data, formatting for ruby
def process(file,cnt,SKL_map,JOB_postings,ARR_names):
	data = extract_data(file)
	if data is None:
		return None
	category = data[0]
	closing = data[1]
	company_name = data[2]
	desc = data[3]
	link = data[4]
	location = data[5]
	logo = data[6]
	title = data[7]
	req_skills = data[8]
	pref_skills = data[9]
	job_type = data[10]

	job_dict = {"full time":0,"part time":1,"contract":2,"casual":3,
			 "summer positions":4,"graduate year recruitment program":5,
			 "field placement/work practicum":6,"internship":7,"volunteer":8}
	if job_type is not None:
		job_type = job_dict[job_type.lower()]

	arr = location.split(',')
	JOBPOSTING = '{title:\"'+title+'\",company_name:\"'+company_name+'\",'
	JOBPOSTING += 'job_category_id: '+get_category_id(category)+','
	JOBPOSTING += 'city:\"'+arr[0]+'\", province: \"'+arr[1]+'\", link: \"'+ link +'\",'
	JOBPOSTING += '' if job_type == None else "job_type: "+str(job_type)+"," 
	JOBPOSTING += 'description: \"'+desc+'\",'
	JOBPOSTING += '' if closing == "" else "close_date: \""+closing+"\""
	JOBPOSTING += '}'

	for j in JOB_postings:
		if JOBPOSTING == j:
			return None

	SKILLS = []
	JOBPOSTINGSKILLS = []

	for s in req_skills:
		skls = process_skills(SKL_map,s,2,cnt,ARR_names)
		if skls[0] is not None:
			SKILLS.append(skls[0])
		JOBPOSTINGSKILLS.append(skls[1])
		SKL_map = skls[2]
			
	for s in pref_skills:
		skls = process_skills(SKL_map,s,1,cnt,ARR_names)
		if skls[0] is not None:
			SKILLS.append(skls[0])
		JOBPOSTINGSKILLS.append(skls[1])
		SKL_map = skls[2]

	return [JOBPOSTING,SKILLS,JOBPOSTINGSKILLS,SKL_map]

def ireplace(old, repl, text):
    return re.sub('(?i)'+re.escape(old), lambda m: repl, text)

def add_skills(skill_str,arr):
	tokenizer = nltk.data.load('tokenizers/punkt/english.pickle')
	if skill_str is not None:
		skill_str = skill_str.lower()
		skill_str = skill_str.strip().replace("\"", "").replace(";", "")
		if not skill_str == "" and len(skill_str) > 1:
			if len(skill_str) > 300:
				tokens = tokenizer.tokenize(skill_str)
				for token in tokens:
					if len(token) < 400:
						arr.append(check_string(token))
			else:
				arr.append(check_string(skill_str))
	return arr

def check_string(string):
	string = string.strip().replace("\"", "'")

	string = string.replace("\r\n","\n")
	string = string.replace("\n ", "\n")

	string = string.replace("\n\n\n", "\n")
	string = string.replace("\n\n", "\n")

	string = string.replace(u'\xa0',u' ')
	string = string.replace(u'\u2018','\'')
	string = string.replace(u'\u2019','\'')
	string = string.replace(u'\u2011','-')
	string = string.replace(u'\u2013','-')
	string = string.replace(u'\u2014','-')
	string = string.replace(u'\u201c','\'')
	string = string.replace(u'\u201d','\'')
	string = string.replace(u'\u2026','...')
	string = string.replace(u'\xae','') #Registered Symbol
	string = string.replace(u'\u2022','') #Bullet Point
	string = string.replace(u'\xab','<<')
	string = string.replace(u'\xb7','.')
	string = string.replace(u'\xbb','>>')
	string = string.replace(u'\xbf','?')
	string = string.replace(u'\xc0','') #A with grave accent
	string = string.replace(u'\xc9','') #E with acute accent
	string = string.replace(u'\xca','') #E with circumflex accent
	string = string.replace(u'\xe0','') #a with grave accent
	string = string.replace(u'\xe1','') #a with acute accent
	string = string.replace(u'\xe2','') #a with circumflex accent
	string = string.replace(u'\xe3','') #a with tilde accent
	string = string.replace(u'\xe4','') #a with diaeresis accent
	string = string.replace(u'\xe5','') #a with ringabove accent
	string = string.replace(u'\xe6','') #ae
	string = string.replace(u'\xe7','') #c with cedilla accent
	string = string.replace(u'\xe8','') #e with grave accent
	string = string.replace(u'\xe9','') #e with acute accent
	string = string.replace(u'\xea','') #e with circumflex accent
	string = string.replace(u'\xeb','') #e with diaeresis accent
	string = string.replace(u'\xec','') #i with grave accent
	string = string.replace(u'\xed','') #i with acute accent
	string = string.replace(u'\xee','') #i with circumflex accent
	string = string.replace(u'\xef','') #i with diaeresis accent
	string = string.replace(u'\xf0','') #eth
	string = string.replace(u'\xf1','') #n with tilde accent
	string = string.replace(u'\xf2','') #o with grave accent
	string = string.replace(u'\xf3','') #o with acute accent
	string = string.replace(u'\xf4','') #o with circumflex accent
	string = string.replace(u'\xf9','') #u with acute accent
	string = string.replace('\\','/')
	string = string.replace(u'\uf0a7','')

	if string.endswith('/') or string.endswith(';'):
		return string[:-1]
	else:
		return string

def get_silbing_ul(elem):
	if elem is not None:
		sibling = elem.getnext()
		if sibling is not None:
			if sibling.tag == "p":
				second_sibling = sibling.getnext()
				if second_sibling is not None:
					sibling = second_sibling
			if sibling.tag == "ul":
				return sibling
	return None

def process_skills(SKL_MAP,s,importance,cnt,ARR_NAMES):
	skill = None
	if s not in SKL_MAP:
		SKL_MAP[s] = len(SKL_MAP)
		skill = '{name: \"'+s+'\"}'
	jobpostingskill = '{skill_id: '+ARR_NAMES[3]+'['+str(SKL_MAP[s])+'].id,job_posting_id: '+ARR_NAMES[2]+'['+str(cnt)+'].id,importance: '+str(importance)+'}'
	return [skill,jobpostingskill,SKL_MAP]

def get_category_id(wCat):
	#Mapping of Workopolis Categories to NAICS codes
	NAICS_switch = {
		"accounting and finance": 52,
		"administrative and clerical": 56,
		"arts, media and entertainment": 71,
		"customer service": 44,
		"engineering": 54,
		"environmental": 11,
		"financial services": 52,
		"healthcare services and wellness": 62,
		"hospitality and food service": 72,
		"human resources and recruitment": 54,
		"insurance": 52,
		"legal": 54,
		"manufacturing": 31,
		"marketing": 54,
		"operations": 55,
		"project management and business analysis": 55,
		"retail in-store": 44,
		"sales and business development": 52,
		"science and research": 54,
		"security and surveillance": 55,
		"skilled trades and labour": 54,
		"supply chain and logistics": 54,
		"technology and digital media": 54,
		"training and education":61}
		#Mapping the NAICS codes to the order in the DB
	ORDER_switch = {11:"1",21:"2",22:"3",23:"4",31:"5",32:"5",33:"5",42:"6",44:"7",45:"7",48:"8",49:"8",51:"9",
					52:"10",53:"11",54:"12",55:"13",56:"14",61:"15",62:"16",71:"17",72:"18",81:"19",92:"20"}
	return ORDER_switch.get(NAICS_switch.get(wCat.lower()),"nil")

def stringifyList(start_str,lst,btwn,end):
	rtn_str = str(start_str)
	for item in lst:
		rtn_str += str(item) + str(btwn)
	rtn_str = rtn_str[:-1] + end
	return rtn_str

def startProgress(title):
    global progress_x
    sys.stdout.write(title + ": [" + " "*40 + "]" + chr(8)*41)
    sys.stdout.flush()
    progress_x = 0

def progress(x):
    global progress_x
    x = int(x * 40 // 100)
    sys.stdout.write("-" * (x - progress_x))
    sys.stdout.flush()
    progress_x = x

def endProgress():
    sys.stdout.write("-" * (40 - progress_x) + "]\n")
    sys.stdout.flush()


# ---------------------------------------
path = os.path.realpath(__file__).strip(__file__)
os.chdir(path)
print("----------- File Processor -----------\n")
print("Ensure the path below contains the file processor and the '/data/categories' folder containing files to process:")
print(path)
print("If it doesn't then cd to the correct path and run again.\n")
print("--------------------------------------------------")

cont = raw_input("Is the path correct? (y/n): ")
cont = str(cont).lower()
if cont == "y" or cont == "yes":
	print("Processing:")
else:
	print("Exiting..")
	exit()

file = open("job_posting_seeds.rb", 'w')
path += "data/categories/"
os.chdir(path)
file.write("puts \"Seeding Auto-Populated Job Posting Data\"\n")

skl_map = {}
JOBPOSTINGS = []
SKILLS = []
JOBPOSTINGSKILLS = []
cnt = 0 
array_names = ["usrs","jcs","jps","ss","jpss"]

#Get Category directories and remove the subdirectories
catdirs = [x[0] for x in os.walk(path)]
del catdirs[0]
keep = []
for c in catdirs:
	if c.split("/")[-2] == "categories":
		keep.append(c)
catdirs = keep

for cdir in catdirs:
	path = cdir
	os.chdir(path)
	print(path.split("/")[-1])
	pointer = 0 
	num_files = 0
	subdirs = [x[0] for x in os.walk(path)]
	del subdirs[0]
	for subdir in subdirs:
		num_files += len([f for f in os.listdir(subdir) if os.path.isfile(os.path.join(subdir, f))])
	num_files -= len(subdirs) + 1
	startProgress("Processing")
	for subdir in subdirs:
		os.chdir(subdir)
		for file_name in os.listdir(subdir):
			rtns = process(file_name,cnt,skl_map,JOBPOSTINGS,array_names)
			try:
				if rtns is not None:
					progress((pointer/num_files)*100)
					JOBPOSTINGS.append(rtns[0])
					SKILLS.extend(rtns[1])
					JOBPOSTINGSKILLS.extend(rtns[2])
					skl_map = rtns[3]
					cnt += 1
			except IndexError:
				do_nothing = True
			pointer += 1
	endProgress()
	print(str(pointer)+" Files Processed.")


print("Concatenating data..")
postings_string = stringifyList(array_names[2]+" = JobPosting.create([", JOBPOSTINGS, ",\n", "])")
skills_string = stringifyList("arr = [", SKILLS, ",\n", "]\n")
jobskills_string = stringifyList(array_names[4]+" = JobPostingSkill.create([", JOBPOSTINGSKILLS, ",\n", "])")

print("Writing to file..")

file.write(postings_string+"\n\n")
file.write(array_names[3]+" = []\n")
file.write(skills_string+"\n")
file.write("arr.each do |a|\n")
file.write("   "+array_names[3]+".push(Skill.find_or_create_by(a))\nend\n\n")

file.write(jobskills_string+"\n\n")

print("Write complete, Created:")
print(str(len(JOBPOSTINGS))+" Job Postings.")
print(str(len(SKILLS))+" Skills.")
print(str(len(JOBPOSTINGSKILLS))+" Job Posting Skill links.")