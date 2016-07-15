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
		if not skill_str == "":
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
	sibling = elem.getnext()
	if sibling is not None:
		if sibling.tag == "p":
			second_sibling = sibling.getnext()
			if second_sibling is not None:
				sibling = second_sibling
		if sibling.tag == "ul":
			return sibling
	return None:

def process_skills(skills,s,importance):
	skill = None
	if s not in skills:
		skills[s] = len(skills)
		skill = '{name: \"'+s+'\"}'
	jobpostingskill = '{skill_id: skills['++'],job_posting_id: '++',importance: '+importance+'}'
	return [skill,jobpostingskill,skills]

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
		skills_strings = ['qualif','skill','abil,','able','capab','experi','criter','knowl','educ','']
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
				if sibling is None:
					next
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
	return [closing,company_name,desc,link,location,logo,title,req_skills,pref_skills]


def process(file,cnt,skill_cnt,companies,user_cnt,file_cat):
		data = extract_data(file)
		closing = data[0]
		company_name = data[1]
		desc = data[2]
		link = data[3]
		location = data[4]
		logo = data[5]
		title = data[6]
		req_skills = data[7]
		pref_skills = data[8]

		USER = ""
		CATEGORY = ""
		if company_name not in companies:
			USER = create_user+ "\""+company_name+"\")"
			companies[company_name] = len(companies)

		if category not in categories:
			CATEGORY = '{name:\"'+category+'\"}'
			categories[category] = len(categories)

		JOBPOSTING = '{title:\"'+title+'\",user_id: usrs['+companies[company_name]+'],'
		JOBPOSTING += 'job_category_id: jcats['+categories[category]+'], location:\"'+location+'\",'
		JOBPOSTING += '' if desc == "" or "<" in desc else "description: \""+desc+"\""
		JOBPOSTING += '' if closing == "" else ",close_date: \"" + closing + "\""
		JOBPOSTING += '}'

		SKILLS = []
		JOBPOSTINGSKILLS = []

		for s in req_skills:
			skls = process_skills(skills,s,2)
			if skls[0] is not None:
				SKILLS.append(skls[0])
			JOBPOSTINGSKILLS.append(skls[1])
			skills = skls[2]
			
		for s in pref_skills:
			skls = process_skills(skills,s,2)
			if skls[0] is not None:
				SKILLS.append(skls[0])
			JOBPOSTINGSKILLS.append(skls[1])
			skills = skls[2]

		return [line,skill_cnt,companies,user_cnt]
	

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

categories = ["Arts, Media and Entertainment","Technology and Digital Media"]
print("----------- Categories -----------")
num = 0 # input number
for c in categories:
	print("[" + str(num) + "] " + c)
	num = num+1
print("----------------------------------")

cat_path = ""
while True:
	cat = input('\nChoose an above Category to process or enter one: ')
	try:
		cat = categories[int(cat)]
	except ValueError:
		cat = cat

	cat_path = "/data/categories/" + cat
	try:
		os.chdir(path+cat_path)
		break
	except FileNotFoundError:
		print("Directory Not Found")
print("----------------------------------")

os.chdir(path)
file = open("job_posting_seeds_"+cat+".rb", 'w')
file.write("puts \"Seeding Job Postings for: "+cat+"\"\n")
file.write("ActiveRecord::Base.transaction do\n")
path+=cat_path
os.chdir(path)

companies = {}
categories = {}
skills = {}
user_cnt = 0 #Switch to amount in map
cnt = 0 #Switch to amount in map?
pointer = 0 
num_files = 0
skill_cnt = 0 #Switch to amount in map?
USERS = []
JOBCATEGORIES = []
JOBPOSTINGS = []
SKILLS = []
JOBPOSTINGSKILLS = []

subdirs = [x[0] for x in os.walk(path)]
del subdirs[0]

for subdir in subdirs:
	num_files += len([f for f in os.listdir(subdir) if os.path.isfile(os.path.join(subdir, f))])
num_files -= len(subdirs) + 1

startProgress("Processing")
for subdir in subdirs:
	os.chdir(subdir)
	for file_name in os.listdir(subdir):
		rtns = process(file_name,cnt,skill_cnt,companies,user_cnt,cat)
		try:
			if not rtns[0] == "":
				progress((pointer/num_files)*100)

				USERS.append(rtn[0])
				JOBCATEGORY.append(rtn[1])
				JOBPOSTINGS.append(rtn[2])
				SKILLS.extend(rtn[3])
				JOBPOSTINGSKILLS.extend([4])
				file.write(rtns[0] + "\n")
				skill_cnt = rtns[1]
				companies = rtns[2]
				user_cnt = rtns[3]
				cnt += 1
		except IndexError:
			do_nothing = True
		pointer += 1
file.write("end\n")
endProgress()
print(str(cnt)+" Files Successfully Processed.")