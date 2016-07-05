# --------------- Imports ---------------
from lxml import html
from lxml.html.clean import clean_html
import requests
import os
import sys
import time
from lxml import etree
# --------------- Functions ---------------
def process(file,cnt,skill_cnt,companies,user_cnt):
	try:
		tree = html.fromstring(open(file, "r").read())
		logo = tree.xpath('//a[@class="job-view-company-logo-link"]/img/@src')
		company_name = tree.xpath('//span[@data-automation="job-company"]')[0].text.title()
		title = tree.xpath('//*[@data-automation="job-title"]')[0].text.title()
		location = tree.xpath('//*[@data-automation="job-Location"]')[0].text.title()
		closing = ""
		link = tree.xpath('//*[@class="page-link"]/@href')
		category = tree.xpath('//a[@class="job-view-header-link link"]')[0].text.title()
		req_skills = []
		pref_skills = []
		desc = []
		skip = False
		skills_strings = ['qualif','skill','abil,','able','capab','experi','criter','knowl','educ','']
		prefer_strings = ['prefer','good','nice','bonus','addit']

		ptags = tree.xpath('//section[@class="job-view-content-wrapper js-job-view-header-apply"]/p')
		for p in ptags:
			ptext = "".join(p.itertext())
			if any(substr in ptext.lower() for substr in skills_strings):
				sibling = p.getnext()
				if sibling is not None:
					if sibling.tag == "ul":
						children = sibling.getchildren()
						for c in children:
							if not c == "\n":
								if any(substr in ptext.lower() for substr in prefer_strings):
									if c.text is not None:
										txt = c.text.strip().replace("\"", "")
										if not txt == "":
											pref_skills.append(txt) 
								else:
									if c.text is not None:
										txt = c.text.strip().replace("\"", "")
										if not txt == "":
											req_skills.append(txt) 

			elif "closing" in ptext.lower() and "date" in ptext.lower() and len(ptext) < 50:
				closing = ptext
			# Can add condition here to get requirements too

			if len(ptext) > 100:
				ptext = ptext.replace("\r\n"," ").replace("\xa0"," ")
				desc.append(ptext)

		desc = ''.join(desc)

		company_name = company_name.strip().replace("\"", "")
		title = title.strip().replace("\"", "")
		location = location.strip().replace("\"", "")
		closing = closing.strip().replace("\"", "")
		desc = desc.strip().replace("\"", "")

		create_job = "JobPosting"+str(cnt)+" = JobPosting.create("
		create_user = "User" + str(user_cnt) + " = create_random_user("
		line = ""

		if req_skills == [] or desc == "":
			return ""

		if company_name not in companies:
			companies[company_name] = user_cnt
			line += create_user+ "\""+company_name+"\")\n"
			user_cnt += 1
		line += "\n"

		line += create_job + "title: \""+title+"\","
		line += "" if desc == "" or "<" in desc else "description: \""+desc+"\","
		line += "location: \""+location +"\","
		line += "link: \""+link+"\","
		line += "category: \""+category+"\","
		line += "" if closing == "" else "close_date: \"" + closing + "\","
		line += "user_id: User"+str(companies[company_name])+".id)"
		line += "\n\n"

		for s in req_skills:
			line += "Skill"+str(skill_cnt)+" = Skill.create(name:\""+s+"\")\n"
			line += "JobPostingSkill"+str(skill_cnt)+" = JobPostingSkill.create(skill_id: Skill"+str(skill_cnt)+".id,job_posting_id: JobPosting"+str(cnt)+".id,importance:2)\n"
			skill_cnt += 1
		for s in pref_skills:
			line += "Skill"+str(skill_cnt)+" = Skill.create(name:\""+s+"\")\n"
			line += "JobPostingSkill"+str(skill_cnt)+" = JobPostingSkill.create(skill_id: Skill"+str(skill_cnt)+".id,job_posting_id: JobPosting"+str(cnt)+".id,importance:2)\n"
			skill_cnt += 1
		line += "\n"
		if "Skill" not in line:
			return ""
		return [line,skill_cnt,companies,user_cnt]
	except:
		return ""

# ---------------------------------------
path = os.path.realpath(__file__).strip(__file__)
os.chdir(path)
file = open("job_posting_seeds.rb", 'w')

cat = input('\nChoose a Category to process: ')
path += "/categories/" + cat
os.chdir(path)
print("----------------------------------")
print("Processing: ")

companies = {}
user_cnt = 0
cnt = 0
skill_cnt = 0
subdirs = [x[0] for x in os.walk(path)]
del subdirs[0]

for subdir in subdirs:
	os.chdir(subdir)
	for file_name in os.listdir(subdir):
		rtns = process(file_name,cnt,skill_cnt,companies,user_cnt)
		try:
			if not rtns[0] == "": 
				print(cnt)
				file.write(rtns[0] + "\n")
				skill_cnt = rtns[1]
				companies = rtns[2]
				user_cnt = rtns[3]
				cnt += 1
		except IndexError:
			do_nothing = True

#Arts, Media and Entertainment