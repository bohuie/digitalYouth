# --------------- Imports ---------------
from lxml import html
from lxml.html.clean import clean_html
import nltk.data
import requests
import os
import sys
import time
from lxml import etree
# --------------- Functions ---------------
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
	string = string.strip().replace("\"", "")
	if "\n\n" in string:
		string = string.replace("\n\n", "\n")

	if string.endswith('\\') or string.endswith(';'):
		return string[:-1]
	else:
		return string

def acronym(string):
	rtn_str = ""
	for i in string.split():
		if i[0].isupper():
			rtn_str += i[0]
	return rtn_str

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

def extract_data(file):
	try:
		tree = html.fromstring(open(file, "r").read())
		logo = tree.xpath('//a[@class="job-view-company-logo-link"]/img/@src')
		company_name = tree.xpath('//span[@data-automation="job-company"]')[0].text.title()
		title = tree.xpath('//*[@data-automation="job-title"]')[0].text.title()
		loc_arr = tree.xpath('//*[@data-automation="job-Location"]')[0].text.title().split(',')
		location = loc_arr[0] + "," + loc_arr[1].upper()
		link = tree.xpath('//*[@class="page-link"]/@href')[0]
		category = tree.xpath('//a[@class="job-view-header-link link"]')[0].text.title()
		closing = ""
		req_skills = []
		pref_skills = []
		desc = []
		#--- Strings to filter by ---
		skills_strings = ['qualif','skill','abil,','able','capab','experi','criter','knowl','educ','criteria']
		prefer_strings = ['prefer','good','nice','bonus','addit']
		benefits_strings = ['benefit']
		roles_strings = ['role']

		tags = tree.xpath('//section[@class="job-view-content-wrapper js-job-view-header-apply"]/*')
		for p in tags:
			ptext = "".join(p.itertext())
			if any(substr in ptext.lower() for substr in benefits_strings): # NOT WORKING
				next
			if any(substr in ptext.lower() for substr in skills_strings):
				sibling = get_silbing_ul(p.getnext())
				if sibling is not None:
					children = sibling.getchildren()
					for c in children:
						if any(substr in ptext.lower() for substr in prefer_strings):
							pref_skills = add_skills(c.text,pref_skills)
						else:
							req_skills = add_skills(c.text,req_skills)

			elif "closing" in ptext.lower() and "date" in ptext.lower() and len(ptext) < 80:
				closing = ptext
			# Can add condition here to get requirements too

			if len(ptext) > 100:
				ptext = ptext.replace("\r\n"," ").replace("\xa0"," ")
				if not any(substr in ptext.lower() for substr in req_skills) and not any(substr in ptext.lower() for substr in pref_skills):
					desc.append(ptext)

		desc = ''.join(desc)
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
	return [category,closing,company_name,desc,link,location,logo,title,req_skills,pref_skills]


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

		JOBPOSTING = '{title:\"'+title+'\",company_name:\"'+company_name+'\",'
		JOBPOSTING += 'job_category_id: '+get_category_id(category)+','
		JOBPOSTING += 'location:\"'+location+'\", link: \"'+ link +'\",'
		JOBPOSTING += '' if desc == "" or "<" in desc else "description: \""+desc+"\""
		JOBPOSTING += '' if closing == "" else ",close_date: \"" + closing + "\""
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

def stringifyList(start_str,lst,btwn):
	rtn_str = str(start_str)
	for item in lst:
		rtn_str += str(item) + str(btwn)
	rtn_str = rtn_str[:-1] + "])"
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
print("Ensure the path below contains the file processor:")
print(path)
print("If it doesn't then cd to the correct path and run again.\n")

print("--------------------------------------------------")
cont = input("Is the path correct? (y/n): ")
cont = str(cont).lower()
if cont == "y" or cont.lower() == "yes":
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


#To print out just skills
#skill_string = '\n'.join(['%s' % (key) for (key, value) in skl_map.items()])
#file.write(skill_string)

print("Concatenating data..")
postings_string = stringifyList(array_names[2]+" = JobPosting.create([",JOBPOSTINGS,",\n")
skills_string = stringifyList(array_names[3]+" = Skill.create([",SKILLS,",\n")
jobskills_string = stringifyList(array_names[4]+" = JobPostingSkill.create([",JOBPOSTINGSKILLS,",\n")

print("Writing to file..")
file.write(postings_string+"\n\n")
file.write(skills_string+"\n\n")
file.write(jobskills_string+"\n\n")
print("Write complete, Created:")
print(str(len(JOBPOSTINGS))+" Job Postings.")
print(str(len(SKILLS))+" Skills.")
print(str(len(JOBPOSTINGSKILLS))+" Job Posting Skill links.")