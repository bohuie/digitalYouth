# --------------- Imports ---------------
from lxml import html
import requests
import os
import sys
import time
from lxml import etree

# --------------- Functions ---------------
def make_connection(url):
	lp = True
	while (lp):
		try:
			page = requests.get(url)
			lp = False
		except (ConnectionError, ConnectionResetError, requests.exceptions.ConnectionError):
			print("Connection error")
			time.sleep(0.01)
	return page

def make_dir(p, new_dir):
	os.chdir(p)
	if not os.path.exists(p + "/" + new_dir):
		os.makedirs(new_dir)
	os.chdir(p + "/" + new_dir)

def make_files(job_links,i,j,k,l):
	for j_link in job_links:
		try:
			page = make_connection("http://www.workopolis.com/" + j_link)
			tree = html.fromstring(page.content)
			section = tree.xpath('//section[@class="main-content job-view-main-content js-analyticsJobView"]')
			side_bar = tree.xpath('//section[@class="sidebar-block sidebar-clean"]')
			#page_cat = tree.xpath('//a[@class="job-view-header-link link"]')
			#if len(page_cat) > 0: Results are too restrictive if we cut all other categories (Too many miscategorized)
			#	page_cat = etree.tostring(page_cat[0]).decode("utf-8")
			if len(section) > 0: #and c_link.text in page_cat:
				page_str = etree.tostring(section[0]).decode("utf-8")
				page_str += etree.tostring(side_bar[0]).decode("utf-8")
				page_str = page_str.replace("&#13;","")

				if len(page_str) > 0:
					file3.write("http://www.workopolis.com" + j_link + "\n")
					file4 = open(str(i) +".html", 'w')
					file4.write("<a class=\"page-link\" href=\"www.workopolis.com"+j_link+"\"></a>\n")
					file4.write(page_str)
					file4.close()
					i += 1 # Increment sub category count
					j += 1 # Increment city count
					l += 1 # Increment category count
				else:
					k += 1 # Increment empty count
			else:
				k += 1 # Increment empty count
		except etree.XMLSyntaxError:
			k += 1 # Increment empty count
	return [i,j,k,l]

def progStr(amount,total):
	prog = round((amount/total)*100)
	if prog == 0:
		return '   '
	if prog < 10:
		return ' '+str(prog)+'%'
	return str(prog)+'%'
# ---------------------------------------
path = os.path.realpath(__file__).strip(__file__)
make_dir(path, "data")
path = path + "/data"
os.chdir(path)
file = open("Categories.txt", 'a')
#file.write('----------- Job Categories -----------\n\n')

make_dir(path, "categories")
path = path + "/categories"

page = make_connection('http://www.workopolis.com/jobsearch/browse-jobs/')
tree = html.fromstring(page.content)
cat_links = tree.xpath('//ul[@class="categoryList"]/li/a')

print("----------- Categories -----------")
num = 0 # input number
for c_link in cat_links:
	print("[" + str(num) + "] " + c_link.text)
	num = num+1
print("----------------------------------")
x = input('\nChoose a Category to Scrape: ')
pg_lvl = int(input('\nPagination Level: '))
print("----------------------------------")
print("Scraping: " + cat_links[int(x)].text)

c_link = cat_links[int(x)]
make_dir(path, c_link.text)
file.write(c_link.text + ": ")
file2 = open("SubCategories.txt", 'w')
file2.write('----------- Sub-Categories -----------\n\n')
cat_path = path + "/" + c_link.text
print("Category LVL: " + c_link.text)

page = make_connection(c_link.xpath('@href')[0])
tree = html.fromstring(page.content)
sub_cat_links = tree.xpath('//ul[@class="jobTitleList"]/li/a')

progress = 0
l = 0 # Category count
empty = 0 # Category empty count
for sc_link in sub_cat_links:
	if sc_link.text != "Select Province":
		make_dir(cat_path, sc_link.text)
		file2.write(sc_link.text + ': ')
		sub_path = cat_path + "/" + sc_link.text
		print(progStr(progress,len(sub_cat_links))+" SubCategory LVL: " + sc_link.text)
		
	if sc_link.text == "Select Province":
		page = make_connection(sc_link.xpath('@href')[0])
		tree = html.fromstring(page.content)
		prov_links = tree.xpath('//ul[@class="provinceList"]/li/a')
		i = 0 # count per sub-category
		file3 = open("index.txt", 'w')

		subcat_progress = 0
		for p_link in prov_links:
			page = make_connection(p_link.xpath('@href')[0])
			tree = html.fromstring(page.content)
			city_links = tree.xpath('//ul[@class="citiesList"]/li/a')
			print(progStr(subcat_progress,len(prov_links))+"  Province LVL: " + p_link.text)
			
			city_progress = 0
			for cl_link in city_links:
				page = make_connection(cl_link.xpath('@href')[0])
				tree = html.fromstring(page.content)
				job_links = tree.xpath('//div[@id="divJobSearchResult"]/article/a/@href')
				print(progStr(city_progress,len(city_links))+"   City LVL: " + cl_link.text)

				j = 0 #count per city
				k = 0 #count empty per city
				rtns = make_files(job_links,i,j,k,l)
				i = rtns[0]
				j = rtns[1]
				k = rtns[2]
				l = rtns[3]

				next_pg = tree.xpath('//a[@class="bjPageNumLink sr-paginator-next"]/@href')
				if len(next_pg) > 0:
					print("       Scraping Paginated results")
					page_cnt = 1
					while len(next_pg) > 0 and page_cnt < pg_lvl:
						page = make_connection(next_pg[0])
						tree = html.fromstring(page.content)
						job_links = tree.xpath('//div[@id="divJobSearchResult"]/article/a/@href')
						rtns = make_files(job_links,i,j,k,l)
						i = rtns[0]
						j = rtns[1]
						k = rtns[2]
						l = rtns[3]
						next_pg = tree.xpath('//a[@class="bjPageNumLink sr-paginator-next"]/@href')
						page_cnt += 1
						print("        PG"+str(page_cnt))

				print("      Scraped: " + str(j) + " | Empty: " + str(k) + " | Total: " + str(j + k))
				empty = empty + k
				city_progress+=1
			subcat_progress += 1

		file3.close()
		file2.write(str(i) + '\n')
	progress += 1

file2.write('\n--------------------------------------\n')
file2.write(str(l) + " Jobs Scraped.\n")
file2.write(str(empty) + " Jobs Skipped.")
file2.close()
file.write(str(l) +'\n')

print("\n--------------------------------------")
print("Finished Scraping: " + cat_links[int(x)].text)
print(str(l) + " Jobs Scraped.")
print(str(empty) + " Jobs Skipped.")