puts "Seeding Categories"
#Orderd by NAICS code 
#Codes are 11,21,22,23,31-33,42,44-45,48-49,51,52,53,54,55,56,61,62,71,72,81,92

JobCategory.create([{name: "Agriculture, Forestry, Fishing, and Hunting"},{name:"Mining"},{name:"Utilities"},
					{name:"Construction"},{name:"Manufacturing"},{name:"Wholesale Trade"},{name:"Retail Trade"},
					{name:"Transportation and Warehousing"},{name:"Information"},{name:"Finance and Insurance"},
					{name:"Real Estate Rental and Leasing"},{name:"Professional, Scientific, and Technical Services"},
					{name:"Management of Companies and Enterprises"},{name:"Administrative and Support and Waste Management and Remediation Services"},
					{name:"Educational Services"},{name:"Health Care and Social Assistance"},{name:"Arts, Entertainment, and Recreation"},
					{name:"Accomodation and Food Services"},{name:"Other Services (except Public Administration)"},{name:"Public Administration"}])