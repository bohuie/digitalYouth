begin
	# This file should contain all the record creation needed to seed the database with its default values.
	# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup) (or rake db:rebuild)
	#
	# Examples:
	#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
	#   Mayor.create(name: 'Emanuel', city: cities.first)


	[:admin, :employee, :employer].each do |role|
	  Role.create({ name: role })
	end

	#----------- Load every seed file in the /seed folder ---------------------
	# Every large set of seeds should be put in a file in the /db/seeds folder
	Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

	puts "Seeding Test Data"

	#--- Skills for Testing ---
	skill1 = Skill.create(name: 'facebook posting')
	skill2 = Skill.create(name: 'twitter posting')
	skill3 = Skill.create(name: 'content creator')
	skill4 = Skill.create(name: 'html')
	skill5 = Skill.create(name: 'time management')
	skill6 = Skill.create(name: 'powerpoint')
	skill7 = Skill.create(name: 'budgeting')
	skill8 = Skill.create(name: 'microsoft office')
	skill9 = Skill.create(name: 'supervision')
	skill10= Skill.create(name: 'java')


	#--- Job Seekers for testing ---#
	#Creating a user with some info
	user1 = User.new(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'password', password_confirmation: 'password',
					 github: 'https://github.com/bohuie/digitalYouth', twitter: 'https://twitter.com/ShawnMendes?lang=en',
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true]) #how to display answered surveys
	user1.add_role :employee
	user1.skip_confirmation!
	user1.save
	user1.create_consent(answer: 1, name: "John Doe", date_signed: Date.today, consent_type: 1)

	#How to do user skills
	UserSkill.create(user_id: user1.id, skill_id: skill1.id, survey_id:11)
	UserSkill.create(user_id: user1.id, skill_id: skill2.id, survey_id:11)
	UserSkill.create(user_id: user1.id, skill_id: skill10.id, survey_id:3)
	UserSkill.create(user_id: user1.id, skill_id: skill5.id, survey_id:7)
	UserSkill.create(user_id: user1.id, skill_id: skill7.id, survey_id:8)

	#Creating projects
	project1 = user1.projects.create(title: 'Java Games', description: 'Created some games', project_date: '2016-09-10')
	project2 = user1.projects.create(title: 'Created a Facebook page', description: 'Created, then managed, a facebook page for a business', project_date: '2016-11-10')

	#Linking projects and skills.  In order to have skills match the user, you must add them to the above list
	ProjectSkill.create(project_id: project1.id, skill_id: skill10.id, survey_id: 3)
	ProjectSkill.create(project_id: project1.id, skill_id: skill5.id, survey_id: 7)
	ProjectSkill.create(project_id: project2.id, skill_id: skill1.id, survey_id: 11)
	ProjectSkill.create(project_id: project2.id, skill_id: skill7.id, survey_id: 8)

	user2 = User.new(first_name: 'Jane', last_name: 'Doe', email: 'jane@doe.com', password: 'password', password_confirmation: 'password')
	user2.add_role :employee
	user2.skip_confirmation!
	user2.save
	user2.create_consent(answer: 0, name: "Jane Doe", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user2.id, skill_id: skill4.id, survey_id:3)
	project3 = user1.projects.create(title: 'Website Development', description: 'Created a website for my employer', project_date: '2016-11-10')
	ProjectSkill.create(project_id: project3.id, skill_id: skill4.id, survey_id: 3)

	user3 = User.new(first_name: 'Kaden', last_name: 'Buchanan', email: 'Kaden@Buchanan.com', password: 'password', password_confirmation: 'password')
	user3.add_role :employee
	user3.skip_confirmation!
	user3.save
	user3.create_consent(answer: 0, name: "Kaden Buchanan", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user3.id, skill_id: skill5.id, survey_id:7)
	UserSkill.create(user_id: user3.id, skill_id: skill10.id, survey_id:3)
	project4 = user1.projects.create(title: 'Java Project', description: 'Had a project with a tight deadline', project_date: '2016-08-06')
	ProjectSkill.create(project_id: project4.id, skill_id: skill5.id, survey_id: 7)
	ProjectSkill.create(project_id: project4.id, skill_id: skill10.id, survey_id: 3)

	user4 = User.new(first_name: 'Mackena', last_name: 'Finley', email: 'Mackena@Finley.com', password: 'password', password_confirmation: 'password')
	user4.add_role :employee
	user4.skip_confirmation!
	user4.save
	user4.create_consent(answer: 0, name: "Mackena Finley", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user4.id, skill_id: skill9.id, survey_id:7)
	project5 = user1.projects.create(title: 'Manager', description: 'Had to supervise a group of people', project_date: '2016-10-01')
	ProjectSkill.create(project_id: project5.id, skill_id: skill9.id, survey_id: 7)

	user5 = User.new(first_name: 'Lenzy', last_name: 'Bennett', email: 'Lenzy@doe.Bennett', password: 'password', password_confirmation: 'password')
	user5.add_role :employee
	user5.skip_confirmation!
	user5.save
	user5.create_consent(answer: 0, name: "Lenzy Bennett", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user5.id, skill_id: skill8.id, survey_id:4)
	project6 = user1.projects.create(title: 'Document Writing', description: 'Wrote up lots of documents and policy for work', project_date: '2016-11-09')
	ProjectSkill.create(project_id: project6.id, skill_id: skill8.id, survey_id: 4)

	user6 = User.new(first_name: 'Jordin', last_name: 'Carroll', email: 'Jordin@Carroll.com', password: 'password', password_confirmation: 'password')
	user6.add_role :employee
	user6.skip_confirmation!
	user6.save
	user6.create_consent(answer: 0, name: "Jordin Carroll", date_signed: Date.today, consent_type: 1)
	UserSkill.create(user_id: user6.id, skill_id: skill1.id, survey_id:11)
	UserSkill.create(user_id: user6.id, skill_id: skill2.id, survey_id:11)

	user7 = User.new(first_name: 'Derryne', last_name: 'Keith', email: 'Derryne@Keith.com', password: 'password', password_confirmation: 'password')
	user7.add_role :employee
	user7.skip_confirmation!
	user7.save
	user7.create_consent(answer: 0, name: "Derryne Keith", date_signed: Date.today, consent_type: 1)
	UserSkill.create(user_id: user7.id, skill_id: skill5.id, survey_id:7)
	UserSkill.create(user_id: user7.id, skill_id: skill7.id, survey_id:8)

	user8 = User.new(first_name: 'Edwyn', last_name: 'Walter', email: 'Edwyn@Walter.com', password: 'password', password_confirmation: 'password')
	user8.add_role :employee
	user8.skip_confirmation!
	user8.save
	user8.create_consent(answer: 0, name: "Edwyn Walter", date_signed: Date.today, consent_type: 1)
	UserSkill.create(user_id: user8.id, skill_id: skill6.id, survey_id:9)
	UserSkill.create(user_id: user8.id, skill_id: skill9.id, survey_id:7)

	user9 = User.new(first_name: 'Kingston', last_name: 'Fletcher', email: 'Kingston@Fletcher.com', password: 'password', password_confirmation: 'password')
	user9.add_role :employee
	user9.skip_confirmation!
	user9.save
	user9.create_consent(answer: 0, name: "Kingston Fletcher", date_signed: Date.today, consent_type: 1)
	UserSkill.create(user_id: user9.id, skill_id: skill8.id, survey_id:4)
	UserSkill.create(user_id: user9.id, skill_id: skill5.id, survey_id:7)

	user10 = User.new(first_name: 'Tyler', last_name: 'Weiss', email: 'Tyler@Weiss.com', password: 'password', password_confirmation: 'password')
	user10.add_role :employee
	user10.skip_confirmation!
	user10.save
	user10.create_consent(answer: 0, name: "Tyler Weiss", date_signed: Date.today, consent_type: 1)
	UserSkill.create(user_id: user10.id, skill_id: skill1.id, survey_id:11)
	UserSkill.create(user_id: user10.id, skill_id: skill10.id, survey_id:3)

	#--- Companies for testing ---
	#Creatinga  company
	user11 = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', password_confirmation: 'password', 
		company_name: 'Google')
	user11.add_role :employer
	user11.skip_confirmation!
	user11.save
	user11.create_consent(answer: 1, name: "Foo Bar", date_signed: Date.today, consent_type: 2)

	#How to post jobs
	jobposting1 = JobPosting.create(title: 'Social Media Manager', location: "Kelowna, BC", pay_range: "30¢/hr-40¢/hr", link:"www.google.ca", posted_by:"Seed File", job_type: 1,
				  description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: Date.today-7, close_date: Date.today+7,
				  job_category_id: 12, user_id: user11.id, created_at:Date.today-7)

	jobposting2 = JobPosting.create(title: 'Social Media Expert', location: "Kelowna, BC", pay_range: "#$30-$40/hr", link:"www.google.ca", posted_by:"Seed File", job_type: 0,
				  description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: Date.today-7, close_date: Date.today,
				  job_category_id: 12, user_id: user11.id, created_at:Date.today-7)

	#Skills attached to a job.  Important 2 is required, 1 is optional.  Ignore question ID for now, have to have some number
	JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill1.id, importance:2, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill2.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill3.id, importance:1, survey_id:7)

	JobPostingSkill.create(job_posting_id: jobposting2.id, skill_id:skill1.id, importance:2, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting2.id, skill_id:skill2.id, importance:2, survey_id:6)

	user12 = User.new(first_name: 'Mikella', last_name: 'Sims', email: 'Mikella@Sims.com', password: 'password', password_confirmation: 'password', 
		company_name: 'Dean Foods Company')
	user12.add_role :employer
	user12.skip_confirmation!
	user12.save
	user12.create_consent(answer: 1, name: "Mikella Sims", date_signed: Date.today, consent_type: 2)
	jobposting3 = JobPosting.create(title: 'Website Developer', location: "Kelowna, BC", pay_range: "30¢/hr-40¢/hr", job_type: 1,
				  description: 'Create a website for our company and maintain it', open_date: Date.today-4, close_date: Date.today+11,
				  job_category_id: 12, user_id: user12.id, created_at:Date.today-7)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill4.id, importance:2, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill5.id, importance:1, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill1.id, importance:1, survey_id:5)

	user13 = User.new(first_name: 'Gomana', last_name: 'Reid', email: 'Gomana@Reid.com', password: 'password', password_confirmation: 'password', 
		company_name: 'H&R Block Inc.')
	user13.add_role :employer
	user13.skip_confirmation!
	user13.save
	user13.create_consent(answer: 1, name: "Gomana Reid", date_signed: Date.today, consent_type: 2)

	user14 = User.new(first_name: 'Daisy', last_name: 'Fitzpatrick', email: 'Daisy@Fitzpatrick.com', password: 'password', password_confirmation: 'password', 
		company_name: 'EOG ResourcesInc.')
	user14.add_role :employer
	user14.skip_confirmation!
	user14.save
	user14.create_consent(answer: 1, name: "Daisy Fitzpatrick", date_signed: Date.today, consent_type: 2)

	user15 = User.new(first_name: 'Hugh', last_name: 'Mcguire', email: 'Hugh@Mcguire.com', password: 'password', password_confirmation: 'password', 
		company_name: 'PETsMART Inc')
	user15.add_role :employer
	user15.skip_confirmation!
	user15.save
	user15.create_consent(answer: 1, name: "Hugh Mcguire", date_signed: Date.today, consent_type: 2)

	user16 = User.new(first_name: 'Maximilian', last_name: 'Hanson', email: 'Maximilian@Hanson.com', password: 'password', password_confirmation: 'password', 
		company_name: "McDonald's Corporation")
	user16.add_role :employer
	user16.skip_confirmation!
	user16.save
	user16.create_consent(answer: 1, name: "Maximilian Hanson", date_signed: Date.today, consent_type: 2)

	user17 = User.new(first_name: 'Karissa', last_name: 'Stafford', email: 'Karissa@Stafford.com', password: 'password', password_confirmation: 'password', 
		company_name: 'Volt Information Sciences Inc')
	user17.add_role :employer
	user17.skip_confirmation!
	user17.save
	user17.create_consent(answer: 1, name: "Karissa Stafford", date_signed: Date.today, consent_type: 2)

	user18 = User.new(first_name: 'Jean', last_name: 'Monroe', email: 'Jean@Monroe.com', password: 'password', password_confirmation: 'password', 
		company_name: 'Potomac Electric Power Co.')
	user18.add_role :employer
	user18.skip_confirmation!
	user18.save
	user18.create_consent(answer: 1, name: "Jean Monroe", date_signed: Date.today, consent_type: 2)

	user19 = User.new(first_name: 'Marcello', last_name: 'Mills', email: 'Marcello@Mills.com', password: 'password', password_confirmation: 'password', 
		company_name: "Toys 'R' Us Inc")
	user19.add_role :employer
	user19.skip_confirmation!
	user19.save
	user19.create_consent(answer: 1, name: "Marcello Mills", date_signed: Date.today, consent_type: 2)

	user20 = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', password_confirmation: 'password', 
		company_name: 'Centex Corp.')
	user20.add_role :employer
	user20.skip_confirmation!
	user20.save
	user20.create_consent(answer: 1, name: "Foo Bar", date_signed: Date.today, consent_type: 2)

	user21 = User.new(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
	user21.add_role :admin
	user21.skip_confirmation!
	user21.save

	#-- Create many random users --
#	if !Rails.env.test?
#		for i in 0...30
#			user = create_random_user(i)

#		end
#	end

	#--- References for testing ---
	reference1 = Reference.create(first_name: 'Bernie', last_name: 'Smith', email: 'Andrew@gmail.com', company: 'Apple Picking Co.',
				 position: "Lead Apple Picker", phone_number:"(250)555-5555", reference_body: "They were the best Apple Picker.", user_id: user1.id)

	reference2 = Reference.create(first_name: 'Bernie', last_name: 'Smith', email: 'Greg@gmail.com', company: 'Apple Pickers United LTD',
				 position: "Apple QC Specialist", phone_number:"(250)555-5050", reference_body: "They were the best.", user_id: user2.id)


	# --- JobPostingApplications for testing ---
	jobpostingapplication = JobPostingApplication.create(message: "This is a message", job_posting_id: jobposting1.id, applicant_id: user1.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "This be a message", job_posting_id: jobposting1.id, applicant_id: user2.id, company_id: user11.id, status:-2)
	

	#--- Survey Responses for testing ---
	#This must be done for each user that has a pre-answered survey
	response1 = Response.create(scores:[3,2,1,0], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user1.id)
	response2 = Response.create(scores:[2,2,1,3], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user1.id)
	response3 = Response.create(scores:[3,3,3,3], question_ids:[9,10,11,12] , survey_id: 3, user_id:user1.id)
	response4 = Response.create(scores:[3,3,1,1], question_ids:[13,14,15,16], survey_id: 4, user_id:user1.id)
	response5 = Response.create(scores:[2,3,2,0], question_ids:[17,18,19,20], survey_id: 5, user_id:user1.id)
	response6 = Response.create(scores:[3,2,3,3], question_ids:[21,22,23,24], survey_id: 6, user_id:user1.id)
	response7 = Response.create(scores:[3,2,3]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user1.id)
	response8 = Response.create(scores:[3,3,0,0], question_ids:[28,29,30,31], survey_id: 8, user_id:user1.id)
	response9 = Response.create(scores:[2,3,2,1], question_ids:[36,37,38,39], survey_id: 10,user_id:user1.id)
	response10= Response.create(scores:[3,2,3,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user1.id)
	response11= Response.create(scores:[3,2,3,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user1.id)


	#----------- Average survey values --------------------------------------------------
	Response.create(scores:[0,0,0,0], question_ids:[1,2,3,4]	, survey_id: 1, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[5,6,7,8]	, survey_id: 2, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[9,10,11,12] , survey_id: 3, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[13,14,15,16], survey_id: 4, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[17,18,19,20], survey_id: 5, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[21,22,23,24], survey_id: 6, user_id:-1)
	Response.create(scores:[0,0,0]  , question_ids:[25,26,27]   , survey_id: 7, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[28,29,30,31], survey_id: 8, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[32,33,34,35], survey_id: 9, user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[36,37,38,39], survey_id: 10,user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[40,41,42,43], survey_id: 11,user_id:-1)
	Response.create(scores:[0,0,0,0], question_ids:[44,45,46,47], survey_id: 12,user_id:-1)


	#----------- Load Job Posting data from scraping and processing ---------------------
	if !Rails.env.test?
		Dir[File.join(Rails.root, 'db', 'scraping', '*.rb')].sort.each { |seed| load seed }
		JobPosting.reindex
	end

rescue Faraday::ConnectionFailed
	puts "\n-------- ERROR --------"
	puts "Failed to connect to external service."
	puts "Try starting elasticSearch server and rerake"
	puts "-----------------------"
end
