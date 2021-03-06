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
	skill11= Skill.create(name: 'mobile app development')
	skill12= Skill.create(name: 'corona sdk')
	skill13= Skill.create(name: 'lua')
	skill14= Skill.create(name: 'storyboarding')
	skill15= Skill.create(name: 'analytics')
	skill16= Skill.create(name: 'online forum posting')
	skill17= Skill.create(name: 'ruby')
	skill18= Skill.create(name: 'presentation')
	skill19= Skill.create(name: 'marketing')
	skill20= Skill.create(name: 'design experience')
	skill21= Skill.create(name: 'google analytics')
	skill22= Skill.create(name: 'mysql')
	skill23= Skill.create(name: 'wordpress')
	skill24= Skill.create(name: 'css')
	skill25= Skill.create(name: 'php')
	skill26= Skill.create(name: 'javascript')
	skill27= Skill.create(name: 'adobe photoshop')
	skill28= Skill.create(name: 'vector graphics')
	skill29= Skill.create(name: 'email campaigns')
	skill30= Skill.create(name: 'market research')
	skill31= Skill.create(name: 'social media marketing')
	skill32= Skill.create(name: 'drupal')
	skill33= Skill.create(name: 'c++')
	skill34= Skill.create(name: 'linux')
	skill35= Skill.create(name: 'seo')
	skill36= Skill.create(name: 'google adwords')
	skill37= Skill.create(name: 'customer service')
	skill38= Skill.create(name: 'windows os')
	skill39= Skill.create(name: 'mobile development')
	skill40= Skill.create(name: '.net framework')
	skill41= Skill.create(name: 'jquery')
	skill42= Skill.create(name: 'vmware')
	skill43= Skill.create(name: 'azure')
	skill44= Skill.create(name: 'sql server')
	skill45= Skill.create(name: 'saas platform')
	skill46= Skill.create(name: 'eclipse')

	user0 = User.new(id: 0, first_name: 'Seed', last_name: 'Data', email: 'seed@data.com', password: 'password', password_confirmation: 'password', company_name: "Seed Data")
	user0.add_role :employer
	user0.skip_confirmation!
	user0.save(validate: false)


	#--- Job Seekers for testing ---#
	#Creating a user with some info
	user1 = User.new(first_name: 'Tyler', last_name: 'Finley', email: 'rsearl.90@gmail.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user1.jpg"), postal_code: 'V1V 1V1', gender: "male", birth_date: "1990-01-01",
					 github: 'https://github.com/RodneyEarl', twitter: 'https://twitter.com/ShawnMendes?lang=en', facebook: 'https://www.facebook.com/rodney.earl.9', linkedin: 'https://ca.linkedin.com/in/rodney-earl-8485094a', summary: 'I am a newly graduated student looking to find a programming job in Kelowna.',
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true]) #how to display answered surveys
	user1.add_role :employee
	user1.skip_confirmation!
	user1.save
	user1.create_consent(answer: 1, name: "Tyler Finley", date_signed: Date.today, consent_type: 1)

	#How to do user skills
	UserSkill.create(user_id: user1.id, skill_id: skill5.id, survey_id:7)
	UserSkill.create(user_id: user1.id, skill_id: skill11.id, survey_id:3)
	UserSkill.create(user_id: user1.id, skill_id: skill12.id, survey_id:3)
	UserSkill.create(user_id: user1.id, skill_id: skill13.id, survey_id:3)
	UserSkill.create(user_id: user1.id, skill_id: skill14.id, survey_id:3)
	UserSkill.create(user_id: user1.id, skill_id: skill15.id, survey_id:12)
	UserSkill.create(user_id: user1.id, skill_id: skill10.id, survey_id:3)

	#Creating projects
	project1 = user1.projects.create(title: 'Mobile Dev game', description: 'Created a game using Corona and Lua.  Also collected data for analytics', project_date: '2017-01-22', image: File.new("#{Rails.root}/app/assets/images/mobigame.png"))
	project2 = user1.projects.create(title: 'Java GUI Game', description: 'Introduction to java, for personal learning.', project_date: '2016-11-10', image: File.new("#{Rails.root}/app/assets/images/puzzle.png"))

	#Linking projects and skills.  If they are not in the user's list, they will be automatically added
	ProjectSkill.create(project_id: project1.id, skill_id: skill11.id, survey_id: 3)
	ProjectSkill.create(project_id: project1.id, skill_id: skill12.id, survey_id: 3)
	ProjectSkill.create(project_id: project1.id, skill_id: skill13.id, survey_id: 3)
	ProjectSkill.create(project_id: project1.id, skill_id: skill14.id, survey_id: 3)
	ProjectSkill.create(project_id: project1.id, skill_id: skill15.id, survey_id: 12)
	ProjectSkill.create(project_id: project2.id, skill_id: skill10.id, survey_id: 3)

	user2 = User.new(first_name: 'Mackena', last_name: 'Carroll', email: 'Mackena@Carroll.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user2.jpg"), gender: "female", birth_date: "1995-11-17",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user2.add_role :employee
	user2.skip_confirmation!
	user2.save
	user2.create_consent(answer: 0, name: "Mackena Carroll", date_signed: Date.today, consent_type: 1)

	
	UserSkill.create(user_id: user2.id, skill_id: skill4.id, survey_id:3)
	UserSkill.create(user_id: user2.id, skill_id: skill16.id, survey_id:6)
	UserSkill.create(user_id: user2.id, skill_id: skill3.id, survey_id:6)
	UserSkill.create(user_id: user2.id, skill_id: skill1.id, survey_id:11)
	UserSkill.create(user_id: user2.id, skill_id: skill2.id, survey_id:11)

	project3 = user2.projects.create(title: 'Concept Navigation', description: 'Online course management that helps users self-regulate their learning, by providing individualized paths.', project_date: '2016-11-10', image: File.new("#{Rails.root}/app/assets/images/ER.png"))
	ProjectSkill.create(project_id: project3.id, skill_id: skill4.id, survey_id: 3)
	ProjectSkill.create(project_id: project3.id, skill_id: skill16.id, survey_id: 6)

	user3 = User.new(first_name: 'Kaden', last_name: 'Buchanan', email: 'Kaden@Buchanan.com', password: 'password', password_confirmation: 'password', city: 'Vernon', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user3.jpg"), gender: "male", birth_date: "1997-03-18",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user3.add_role :employee
	user3.skip_confirmation!
	user3.save
	user3.create_consent(answer: 0, name: "Kaden Buchanan", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user3.id, skill_id: skill5.id, survey_id:7)
	UserSkill.create(user_id: user3.id, skill_id: skill10.id, survey_id:3)
	UserSkill.create(user_id: user3.id, skill_id: skill16.id, survey_id:3)
	UserSkill.create(user_id: user3.id, skill_id: skill9.id, survey_id:7)

	project4 = user3.projects.create(title: 'Digital Citizenship', description: 'Developed class to engage students in community, digital citizenship.  Used flipped classroom technique.', project_date: '2016-08-06', image: File.new("#{Rails.root}/app/assets/images/dc.png"))
	ProjectSkill.create(project_id: project4.id, skill_id: skill16.id, survey_id: 3)
	ProjectSkill.create(project_id: project4.id, skill_id: skill9.id, survey_id: 7)

	user4 = User.new(first_name: 'Mackena', last_name: 'Finley', email: 'Mackena@Finley.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user4.jpg"), gender: "female", birth_date: "1992-03-01",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user4.add_role :employee
	user4.skip_confirmation!
	user4.save
	user4.create_consent(answer: 0, name: "Mackena Finley", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user4.id, skill_id: skill9.id, survey_id:7)
	UserSkill.create(user_id: user4.id, skill_id: skill17.id, survey_id:3)
	UserSkill.create(user_id: user4.id, skill_id: skill18.id, survey_id:7)

	project5 = user4.projects.create(title: 'KRIT Physics Tutor', description: 'Implementation of a physics tutoring software that uses AI to help plan a learning path.', project_date: '2016-10-01', image: File.new("#{Rails.root}/app/assets/images/menu.png"))
	ProjectSkill.create(project_id: project5.id, skill_id: skill17.id, survey_id: 3)
	ProjectSkill.create(project_id: project5.id, skill_id: skill18.id, survey_id: 7)

	user5 = User.new(first_name: 'Lenzy', last_name: 'Bennett', email: 'Lenzy@Bennett.com', password: 'password', password_confirmation: 'password', city: 'Penticton', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user5.jpg"), gender: "female", birth_date: "1990-01-01",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user5.add_role :employee
	user5.skip_confirmation!
	user5.save
	user5.create_consent(answer: 0, name: "Lenzy Bennett", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user5.id, skill_id: skill8.id, survey_id:4)
	UserSkill.create(user_id: user5.id, skill_id: skill12.id, survey_id:3)
	UserSkill.create(user_id: user5.id, skill_id: skill1.id, survey_id:3)


	project6 = user5.projects.create(title: 'Educational Games', description: 'Create games that are to assist in teaching, by engaging the students.', project_date: '2016-11-09', image: File.new("#{Rails.root}/app/assets/images/gameMods.jpg"))
	ProjectSkill.create(project_id: project6.id, skill_id: skill12.id, survey_id: 3)
	ProjectSkill.create(project_id: project6.id, skill_id: skill13.id, survey_id: 3)

	user6 = User.new(first_name: 'Jordin', last_name: 'Carroll', email: 'Jordin@Carroll.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user6.jpg"), gender: "female", birth_date: "1992-09-23",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user6.add_role :employee
	user6.skip_confirmation!
	user6.save
	user6.create_consent(answer: 0, name: "Jordin Carroll", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user6.id, skill_id: skill1.id, survey_id:11)
	UserSkill.create(user_id: user6.id, skill_id: skill2.id, survey_id:11)
	UserSkill.create(user_id: user6.id, skill_id: skill5.id, survey_id:7)
	UserSkill.create(user_id: user6.id, skill_id: skill7.id, survey_id:8)

	user7 = User.new(first_name: 'Derryne', last_name: 'Keith', email: 'Derryne@Keith.com', password: 'password', password_confirmation: 'password', city: 'Vernon', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user7.jpg"), gender: "female", birth_date: "1991-08-05",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user7.add_role :employee
	user7.skip_confirmation!
	user7.save
	user7.create_consent(answer: 0, name: "Derryne Keith", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user7.id, skill_id: skill5.id, survey_id:7)
	UserSkill.create(user_id: user7.id, skill_id: skill7.id, survey_id:8)

	user8 = User.new(first_name: 'Edwyn', last_name: 'Walter', email: 'Edwyn@Walter.com', password: 'password', password_confirmation: 'password', city: 'Penticton', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user8.jpg"), gender: "male", birth_date: "1990-07-29",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user8.add_role :employee
	user8.skip_confirmation!
	user8.save
	user8.create_consent(answer: 0, name: "Edwyn Walter", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user8.id, skill_id: skill2.id, survey_id:9)
	UserSkill.create(user_id: user8.id, skill_id: skill9.id, survey_id:7)

	user9 = User.new(first_name: 'Kingston', last_name: 'Fletcher', email: 'Kingston@Fletcher.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user9.jpg"), gender: "male", birth_date: "1995-09-18",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user9.add_role :employee
	user9.skip_confirmation!
	user9.save
	user9.create_consent(answer: 0, name: "Kingston Fletcher", date_signed: Date.today, consent_type: 1)

	UserSkill.create(user_id: user9.id, skill_id: skill8.id, survey_id:4)
	UserSkill.create(user_id: user9.id, skill_id: skill5.id, survey_id:7)

	user10 = User.new(first_name: 'Tyler', last_name: 'Weiss', email: 'Tyler@Weiss.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user10.jpg"), gender: "male", birth_date: "1987-05-27",
					 answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
	user10.add_role :employee
	user10.skip_confirmation!
	user10.save
	user10.create_consent(answer: 0, name: "Tyler Weiss", date_signed: Date.today, consent_type: 1)
	
	UserSkill.create(user_id: user10.id, skill_id: skill1.id, survey_id:11)
	UserSkill.create(user_id: user10.id, skill_id: skill10.id, survey_id:3)

	#--- Companies for testing ---
	#Creatinga  company
	user11 = User.new(first_name: 'Hugh', last_name: 'Mcguire', email: 'Hugh@Mcguire.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', postal_code: 'V1V 1V1', street_address: '1000 Harvey Ave.', gender: "male", birth_date: "1980-07-12",
		company_name: 'PetSmart Inc.', bio:'We love pets and we believe pets make us better people. PetSmart will be the trusted partner to pet parents and pets in every moment of their lives.', image: File.new("#{Rails.root}/app/assets/images/user11.png"), 
		twitter: 'https://twitter.com/ShawnMendes?lang=en', facebook: 'https://www.facebook.com/rodney.earl.9', linkedin: 'https://ca.linkedin.com/in/rodney-earl-8485094a', summary: 'We are looking for someone to host our Social Media accounts.')
	user11.add_role :employer
	user11.skip_confirmation!
	user11.save
	user11.create_consent(answer: 1, name: "Hugh Mcguire", date_signed: Date.today, consent_type: 2)

	#How to post jobs
	jobposting1 = JobPosting.create(title: 'Social Media Manager', city: "Kelowna", province: "BC", pay_rate: 'yearly', lower_pay_range: 40000.00, upper_pay_range: 45000.00, job_type: 1,
				  description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: Date.today-7, close_date: Date.today+7,
				  job_category_id: 12, user_id: user11.id, created_at:Date.today-7)

	jobposting2 = JobPosting.create(title: 'Social Media Expert', city: "Vernon", province: "BC", pay_rate: "hourly", lower_pay_range: 13.81, upper_pay_range: 15.60, posted_by:"Seed File", job_type: 0,
				  description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: Date.today-30, close_date: Date.today+12,
				  job_category_id: 12, user_id: user11.id, created_at:Date.today-7)

	jobposting3 = JobPosting.create(title: 'Front End Web Developer w/ Graphic Design Experience', city: "Penticton", province: "BC", pay_rate: "yearly", lower_pay_range: 50000, upper_pay_range: 70000, posted_by:"Seed File", job_type: 0,
				  description: 'Your front end development work will vary from coding high quality landing pages, setting up split-tests, and monitoring tracking to create a better customer experience.', open_date: Date.today-7, close_date: Date.today,
				  job_category_id: 12, user_id: user11.id, created_at:Date.today-7)

	jobposting4 = JobPosting.create(title: 'Digital Product Marketing Strategist', city: "Kelowna", province: "BC", pay_rate: "hourly", lower_pay_range: 20.00, upper_pay_range: 25.00, posted_by:"Seed File", job_type: 0,
				  description: 'Our products team is looking for a digital marketing strategist ready to flex their marketing muscles in a remote team environment. If strategic planning for software products is your jam and you’re based in North America, let’s talk.', open_date: Date.today-7, close_date: Date.today+12,
				  job_category_id: 12, user_id: user11.id, created_at:Date.today-7)

	jobposting5 = JobPosting.create(title: 'Senior Digital Marketing Project Manager', city: "Vernon", province: "BC", pay_rate: "yearly", lower_pay_range: 60000, upper_pay_range: 65000, posted_by:"Seed File", job_type: 0,
				  description: 'Looking for a Digital Marketing Project Manager to effectively manage multiple digital campaigns and develop ongoing marketing strategies.', open_date: Date.today-10, close_date: Date.today+13,
				  job_category_id: 12, user_id: user11.id, created_at:Date.today-7)

	#Skills attached to a job.  Important 2 is required, 1 is optional.  Ignore question ID for now, have to have some number
	JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill1.id, importance:2, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill2.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill3.id, importance:1, survey_id:7)

	JobPostingSkill.create(job_posting_id: jobposting2.id, skill_id:skill1.id, importance:2, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting2.id, skill_id:skill2.id, importance:2, survey_id:6)

	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill23.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill24.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill25.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill4.id,  importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill26.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill27.id, importance:2, survey_id:10)
	JobPostingSkill.create(job_posting_id: jobposting3.id, skill_id:skill28.id, importance:1, survey_id:10)

	JobPostingSkill.create(job_posting_id: jobposting4.id, skill_id:skill18.id, importance:2, survey_id:9)
	JobPostingSkill.create(job_posting_id: jobposting4.id, skill_id:skill19.id, importance:2, survey_id:7)
	JobPostingSkill.create(job_posting_id: jobposting4.id, skill_id:skill20.id, importance:2, survey_id:10)
	JobPostingSkill.create(job_posting_id: jobposting4.id, skill_id:skill21.id, importance:2, survey_id:7)
	JobPostingSkill.create(job_posting_id: jobposting4.id, skill_id:skill22.id, importance:1, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting4.id, skill_id:skill23.id, importance:2, survey_id:3)

	JobPostingSkill.create(job_posting_id: jobposting5.id, skill_id:skill21.id, importance:2, survey_id:7)
	JobPostingSkill.create(job_posting_id: jobposting5.id, skill_id:skill29.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting5.id, skill_id:skill30.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting5.id, skill_id:skill31.id, importance:2, survey_id:11)
	JobPostingSkill.create(job_posting_id: jobposting5.id, skill_id:skill32.id, importance:1, survey_id:3)

	user12 = User.new(first_name: 'Mikella', last_name: 'Sims', email: 'Mikella@Sims.com', password: 'password', password_confirmation: 'password', city: 'Penticton', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user12.png"), gender: "female", birth_date: "1987-06-16",
		company_name: 'Dean Foods Company')
	user12.add_role :employer
	user12.skip_confirmation!
	user12.save
	user12.create_consent(answer: 1, name: "Mikella Sims", date_signed: Date.today, consent_type: 2)
	jobposting6 = JobPosting.create(title: 'Website Developer', city: "Penticton", province: "BC", pay_rate: "hourly", lower_pay_range: 12.50, job_type: 1,
				  description: 'Create a website for our company and maintain it', open_date: Date.today-4, close_date: Date.today+11,
				  job_category_id: 12, user_id: user12.id, created_at:Date.today-7)

	jobposting7 = JobPosting.create(title: 'Digital Marketing Project Coordinator', city: "Kelowna", province: "BC", pay_rate: "yearly", lower_pay_range: 70000, upper_pay_range: 90000, posted_by:"Seed File", job_type: 0,
				  description: 'Looking for a Digital Marketing Project Coordinator to effectively manage multiple digital campaigns and develop ongoing marketing strategies.', open_date: Date.today-10, close_date: Date.today+13,
				  job_category_id: 12, user_id: user12.id, created_at:Date.today-7)

	jobposting8 = JobPosting.create(title: 'Drupal Developer', city: "Vernon", province: "BC", pay_rate: "hourly", lower_pay_range: 24.25, upper_pay_range: 27.00, posted_by:"Seed File", job_type: 0,
				  description: 'Here’s what we really want, someone who can code like it’s their native tongue but still talk to our crew comfortably and sometimes even the odd client.', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user12.id, created_at:Date.today-7)

	jobposting9 = JobPosting.create(title: 'Digital Media and Marketing Lead ', city: "Penticton", province: "BC", pay_rate: "yearly", lower_pay_range: 55000, upper_pay_range: 65000, posted_by:"Seed File", job_type: 0,
				  description: 'Our primary focus will be on digital marketing, social media – website management and content creation that drives sales and engagement..', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user12.id, created_at:Date.today-7)

	jobposting10= JobPosting.create(title: 'Digital Marketing Specialist ', city: "Penticton", province: "BC", pay_rate: "hourly", lower_pay_range: 18.50, upper_pay_range: 25.00, posted_by:"Seed File", job_type: 0,
				  description: 'Your main responsibilities will include working with a set list of client SEO accounts, engaging in social media activity, continuously analyzing keyword ranking progress, advertising activity, and developing strategies as needed.', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user12.id, created_at:Date.today-7)

	JobPostingSkill.create(job_posting_id: jobposting6.id, skill_id:skill4.id, importance:2, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting6.id, skill_id:skill5.id, importance:1, survey_id:5)
	JobPostingSkill.create(job_posting_id: jobposting6.id, skill_id:skill1.id, importance:1, survey_id:5)

	JobPostingSkill.create(job_posting_id: jobposting7.id, skill_id:skill29.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting7.id, skill_id:skill30.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting7.id, skill_id:skill31.id, importance:2, survey_id:11)

	JobPostingSkill.create(job_posting_id: jobposting8.id, skill_id:skill32.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting8.id, skill_id:skill33.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting8.id, skill_id:skill34.id, importance:2, survey_id:1)
	JobPostingSkill.create(job_posting_id: jobposting8.id, skill_id:skill24.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting8.id, skill_id:skill25.id, importance:2, survey_id:3)

	JobPostingSkill.create(job_posting_id: jobposting9.id, skill_id:skill15.id, importance:2, survey_id:7)
	JobPostingSkill.create(job_posting_id: jobposting9.id, skill_id:skill28.id, importance:2, survey_id:10)
	JobPostingSkill.create(job_posting_id: jobposting9.id, skill_id:skill30.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting9.id, skill_id:skill31.id, importance:2, survey_id:11)
	JobPostingSkill.create(job_posting_id: jobposting9.id, skill_id:skill35.id, importance:1, survey_id:6)

	JobPostingSkill.create(job_posting_id: jobposting10.id, skill_id:skill8.id, importance:2, survey_id:4)
	JobPostingSkill.create(job_posting_id: jobposting10.id, skill_id:skill21.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting10.id, skill_id:skill36.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting10.id, skill_id:skill32.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting10.id, skill_id:skill35.id, importance:1, survey_id:6)

	user13 = User.new(first_name: 'Gomana', last_name: 'Reid', email: 'Gomana@Reid.com', password: 'password', password_confirmation: 'password', city: 'Penticton', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user13.jpg"), gender: "female", birth_date: "1982-12-01",
		company_name: 'H&R Block Inc.')
	user13.add_role :employer
	user13.skip_confirmation!
	user13.save
	user13.create_consent(answer: 1, name: "Gomana Reid", date_signed: Date.today, consent_type: 2)

	jobposting11= JobPosting.create(title: 'Content Director / Community Manager', city: "Penticton", province: "BC", pay_rate: "hourly", lower_pay_range: 28.25	, posted_by:"Seed File", job_type: 0,
				  description: 'create business listings, ePages and blog posts and advertisements', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user13.id, created_at:Date.today-7)

	JobPostingSkill.create(job_posting_id: jobposting11.id, skill_id:skill16.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting11.id, skill_id:skill28.id, importance:2, survey_id:10)
	JobPostingSkill.create(job_posting_id: jobposting11.id, skill_id:skill36.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting11.id, skill_id:skill32.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting11.id, skill_id:skill35.id, importance:1, survey_id:6)

	jobposting12= JobPosting.create(title: 'Multi-Media Producer', city: "Kelowna", province: "BC", pay_rate: "hourly", lower_pay_range: 18.25, upper_pay_range: 27.00, posted_by:"Seed File", job_type: 0,
				  description: 'We are looking for a multi-media producer with strong digital media production and communication skills, customer service orientation, and creativity.', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user13.id, created_at:Date.today-7)

	JobPostingSkill.create(job_posting_id: jobposting12.id, skill_id:skill8.id, importance:2, survey_id:4)
	JobPostingSkill.create(job_posting_id: jobposting12.id, skill_id:skill37.id, importance:2, survey_id:7)
	JobPostingSkill.create(job_posting_id: jobposting12.id, skill_id:skill39.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting12.id, skill_id:skill38.id, importance:1, survey_id:1)

	jobposting13= JobPosting.create(title: 'Technical Support Analyst', city: "Vernon", province: "BC", pay_rate: "hourly", lower_pay_range: 18.50, upper_pay_range: 25.00, posted_by:"Seed File", job_type: 0,
				  description: 'Our client requires a technical support analyst. As a key member of the Support team, you will be primarily responsible for providing first and second level technical, desktop, and application support to users.', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user13.id, created_at:Date.today-7)

	JobPostingSkill.create(job_posting_id: jobposting13.id, skill_id:skill8.id, importance:2, survey_id:4)
	JobPostingSkill.create(job_posting_id: jobposting13.id, skill_id:skill21.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting13.id, skill_id:skill36.id, importance:2, survey_id:6)
	JobPostingSkill.create(job_posting_id: jobposting13.id, skill_id:skill32.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting13.id, skill_id:skill35.id, importance:1, survey_id:6)

	jobposting14= JobPosting.create(title: 'System Administrator', city: "Penticton", province: "BC", pay_rate: "hourly", lower_pay_range: 22.50, upper_pay_range: 25.00, posted_by:"Seed File", job_type: 0,
				  description: 'The position requires a candidate that will participate in the design, configuration, and deployment of several technical projects. The successful candidate must be have deep knowledge in a wide variety of IT technologies, be a self-starter, be customer service oriented, and be passionate about technology. This position will be for 6 months with option to extend.', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user13.id, created_at:Date.today-7)

	JobPostingSkill.create(job_posting_id: jobposting14.id, skill_id:skill41.id, importance:2, survey_id:1)
	JobPostingSkill.create(job_posting_id: jobposting14.id, skill_id:skill42.id, importance:2, survey_id:1)
	JobPostingSkill.create(job_posting_id: jobposting14.id, skill_id:skill43.id, importance:2, survey_id:1)
	JobPostingSkill.create(job_posting_id: jobposting14.id, skill_id:skill44.id, importance:2, survey_id:1)
	JobPostingSkill.create(job_posting_id: jobposting14.id, skill_id:skill34.id, importance:1, survey_id:1)

	jobposting15= JobPosting.create(title: 'Java Developer', city: "Kelowna", province: "BC", pay_rate: "hourly", lower_pay_range: 19.50, upper_pay_range: 23.00, posted_by:"Seed File", job_type: 0,
				  description: 'This developer will work with a team of frontend and backend developers in a fast-paced agile environment and interface with other product team members to implement new features in short customer-ready release cycles.', open_date: Date.today-10, close_date: Date.today+10,
				  job_category_id: 12, user_id: user13.id, created_at:Date.today-7)

	JobPostingSkill.create(job_posting_id: jobposting15.id, skill_id:skill26.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting15.id, skill_id:skill10.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting15.id, skill_id:skill24.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting15.id, skill_id:skill45.id, importance:2, survey_id:3)
	JobPostingSkill.create(job_posting_id: jobposting15.id, skill_id:skill46.id, importance:1, survey_id:3)

	user14 = User.new(first_name: 'Daisy', last_name: 'Fitzpatrick', email: 'Daisy@Fitzpatrick.com', password: 'password', password_confirmation: 'password', city: 'Vernon', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user14.jpg"), gender: "female", birth_date: "1997-02-18",
		company_name: 'EOG ResourcesInc.')
	user14.add_role :employer
	user14.skip_confirmation!
	user14.save
	user14.create_consent(answer: 1, name: "Daisy Fitzpatrick", date_signed: Date.today, consent_type: 2)

	user15 = User.new(first_name: 'Jess', last_name: 'McGomack', email: 'jess@mcgomack.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user15.png"), gender: "female", birth_date: "1990-07-16",
		company_name: 'Google')
	user15.add_role :employer
	user15.skip_confirmation!
	user15.save
	user15.create_consent(answer: 1, name: "Jess McGomack", date_signed: Date.today, consent_type: 2)

	user16 = User.new(first_name: 'Maximilian', last_name: 'Hanson', email: 'Maximilian@Hanson.com', password: 'password', password_confirmation: 'password', city: 'Penticton', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user16.jpg"), gender: "male", birth_date: "1991-04-30",
		company_name: "McDonald's Corporation")
	user16.add_role :employer
	user16.skip_confirmation!
	user16.save
	user16.create_consent(answer: 1, name: "Maximilian Hanson", date_signed: Date.today, consent_type: 2)

	user17 = User.new(first_name: 'Karissa', last_name: 'Stafford', email: 'Karissa@Stafford.com', password: 'password', password_confirmation: 'password', city: 'Vernon', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user17.jpeg"), gender: "female", birth_date: "1988-10-13",
		company_name: 'Volt Information Sciences Inc')
	user17.add_role :employer
	user17.skip_confirmation!
	user17.save
	user17.create_consent(answer: 1, name: "Karissa Stafford", date_signed: Date.today, consent_type: 2)

	user18 = User.new(first_name: 'Jean', last_name: 'Monroe', email: 'Jean@Monroe.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user18.png"), gender: "female", birth_date: "1988-05-18",
		company_name: 'Potomac Electric Power Co.')
	user18.add_role :employer
	user18.skip_confirmation!
	user18.save
	user18.create_consent(answer: 1, name: "Jean Monroe", date_signed: Date.today, consent_type: 2)

	user19 = User.new(first_name: 'Marcello', last_name: 'Mills', email: 'Marcello@Mills.com', password: 'password', password_confirmation: 'password', city: 'Vernon', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user19.png"), gender: "male", birth_date: "1983-02-01",
		company_name: "Toys 'R' Us Inc")
	user19.add_role :employer
	user19.skip_confirmation!
	user19.save
	user19.create_consent(answer: 1, name: "Marcello Mills", date_signed: Date.today, consent_type: 2)

	user20 = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'password', password_confirmation: 'password', city: 'Penticton', province: 'BC', image: File.new("#{Rails.root}/app/assets/images/user20.png"), gender: "male", birth_date: "1985-05-01",
		company_name: 'Centex Corp.')
	user20.add_role :employer
	user20.skip_confirmation!
	user20.save
	user20.create_consent(answer: 1, name: "John Smith", date_signed: Date.today, consent_type: 2)

	user21 = User.new(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password', city: 'Kelowna', province: 'BC', gender: "male", birth_date: "1990-01-01")
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
	reference1 = Reference.create!(first_name: 'Bernie', last_name: 'Smith', company: 'Apple Picking Co.',
				 position: "Lead Apple Picker", reference_body: "He was the best Apple Picker.", user_id: user1.id)
	reference1 = Reference.create(first_name: user11.first_name, last_name: user11.last_name, company: user11.company_name,
				 position: "Developer", reference_body: "Tyler was a good developer.  He coded many different projects for us, using various skills from different languages.  While working with us, he learned how to do mobile development, and ended up leading a group on another mobile project.", user_id: user1.id)

	reference2 = Reference.create(first_name: 'Bernie', last_name: 'Smith', company: 'Apple Pickers United LTD',
				 position: "Apple QC Specialist", reference_body: "He was the best.", user_id: user2.id)


	# --- JobPostingApplications for testing ---
	jobpostingapplication = JobPostingApplication.create(message: "Hello Mr Mcguire.  I believe I would be a strong candidate for your position, with an eagerness to learn.  I am an avid pet lover, and would love to work with a company that helps pets.", 
		job_posting_id: jobposting1.id, applicant_id: user1.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "I have had much experience maintaining social media accounts.  I have led Facebook and Twitter outreach programs for other companies, and I feel like I would be a good fit with you and your company.", 
		job_posting_id: jobposting1.id, applicant_id: user2.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar ", 
		job_posting_id: jobposting2.id, applicant_id: user3.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar ", 
		job_posting_id: jobposting2.id, applicant_id: user4.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar ", 
		job_posting_id: jobposting2.id, applicant_id: user5.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar ", 
		job_posting_id: jobposting2.id, applicant_id: user6.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar ", 
		job_posting_id: jobposting2.id, applicant_id: user7.id, company_id: user11.id, status: 0)
	jobpostingapplication = JobPostingApplication.create(message: "Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar Foo bar ", 
		job_posting_id: jobposting2.id, applicant_id: user8.id, company_id: user11.id, status: 0)
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


	response1 = Response.create(scores:[2,2,1,0], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user2.id)
	response2 = Response.create(scores:[2,1,1,0], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user2.id)
	response3 = Response.create(scores:[3,3,3,3], question_ids:[9,10,11,12] , survey_id: 3, user_id:user2.id)
	response4 = Response.create(scores:[3,3,2,1], question_ids:[13,14,15,16], survey_id: 4, user_id:user2.id)
	response5 = Response.create(scores:[2,3,2,0], question_ids:[17,18,19,20], survey_id: 5, user_id:user2.id)
	response6 = Response.create(scores:[3,3,3,3], question_ids:[21,22,23,24], survey_id: 6, user_id:user2.id)
	response7 = Response.create(scores:[2,3,1]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user2.id)
	response8 = Response.create(scores:[2,1,0,0], question_ids:[28,29,30,31], survey_id: 8, user_id:user2.id)
	response9 = Response.create(scores:[1,1,0,0], question_ids:[36,37,38,39], survey_id: 10,user_id:user2.id)
	response10= Response.create(scores:[3,2,1,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user2.id)
	response11= Response.create(scores:[3,2,2,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user2.id)


	response1 = Response.create(scores:[3,3,3,3], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user3.id)
	response2 = Response.create(scores:[2,2,1,1], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user3.id)
	response3 = Response.create(scores:[3,2,1,1], question_ids:[9,10,11,12] , survey_id: 3, user_id:user3.id)
	response4 = Response.create(scores:[3,3,3,2], question_ids:[13,14,15,16], survey_id: 4, user_id:user3.id)
	response5 = Response.create(scores:[2,2,2,1], question_ids:[17,18,19,20], survey_id: 5, user_id:user3.id)
	response6 = Response.create(scores:[2,2,1,1], question_ids:[21,22,23,24], survey_id: 6, user_id:user3.id)
	response7 = Response.create(scores:[1,1,3]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user3.id)
	response8 = Response.create(scores:[2,1,0,1], question_ids:[28,29,30,31], survey_id: 8, user_id:user3.id)
	response9 = Response.create(scores:[3,1,0,0], question_ids:[36,37,38,39], survey_id: 10,user_id:user3.id)
	response10= Response.create(scores:[1,2,1,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user3.id)
	response11= Response.create(scores:[2,2,2,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user3.id)

	response1 = Response.create(scores:[3,2,2,1], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user4.id)
	response2 = Response.create(scores:[1,0,0,0], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user4.id)
	response3 = Response.create(scores:[1,0,0,0], question_ids:[9,10,11,12] , survey_id: 3, user_id:user4.id)
	response4 = Response.create(scores:[3,2,1,1], question_ids:[13,14,15,16], survey_id: 4, user_id:user4.id)
	response5 = Response.create(scores:[2,2,2,1], question_ids:[17,18,19,20], survey_id: 5, user_id:user4.id)
	response6 = Response.create(scores:[2,2,1,1], question_ids:[21,22,23,24], survey_id: 6, user_id:user4.id)
	response7 = Response.create(scores:[2,2,3]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user4.id)
	response8 = Response.create(scores:[2,1,1,1], question_ids:[28,29,30,31], survey_id: 8, user_id:user4.id)
	response9 = Response.create(scores:[3,1,0,0], question_ids:[36,37,38,39], survey_id: 10,user_id:user4.id)
	response10= Response.create(scores:[2,2,1,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user4.id)
	response11= Response.create(scores:[2,2,2,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user4.id)

	response1 = Response.create(scores:[3,3,3,3], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user5.id)
	response2 = Response.create(scores:[2,2,1,1], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user5.id)
	response3 = Response.create(scores:[3,2,1,1], question_ids:[9,10,11,12] , survey_id: 3, user_id:user5.id)
	response4 = Response.create(scores:[3,3,3,2], question_ids:[13,14,15,16], survey_id: 4, user_id:user5.id)
	response5 = Response.create(scores:[2,2,2,1], question_ids:[17,18,19,20], survey_id: 5, user_id:user5.id)
	response6 = Response.create(scores:[2,2,1,1], question_ids:[21,22,23,24], survey_id: 6, user_id:user5.id)
	response7 = Response.create(scores:[1,1,3]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user5.id)
	response8 = Response.create(scores:[2,1,0,1], question_ids:[28,29,30,31], survey_id: 8, user_id:user5.id)
	response9 = Response.create(scores:[3,1,0,0], question_ids:[36,37,38,39], survey_id: 10,user_id:user5.id)
	response10= Response.create(scores:[1,2,1,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user5.id)
	response11= Response.create(scores:[2,2,2,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user5.id)

	response1 = Response.create(scores:[3,3,3,3], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user6.id)
	response2 = Response.create(scores:[3,3,2,2], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user6.id)
	response3 = Response.create(scores:[3,2,1,1], question_ids:[9,10,11,12] , survey_id: 3, user_id:user6.id)
	response4 = Response.create(scores:[3,3,2,2], question_ids:[13,14,15,16], survey_id: 4, user_id:user6.id)
	response5 = Response.create(scores:[2,2,2,1], question_ids:[17,18,19,20], survey_id: 5, user_id:user6.id)
	response6 = Response.create(scores:[3,2,2,2], question_ids:[21,22,23,24], survey_id: 6, user_id:user6.id)
	response7 = Response.create(scores:[1,1,3]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user6.id)
	response8 = Response.create(scores:[2,1,0,1], question_ids:[28,29,30,31], survey_id: 8, user_id:user6.id)
	response9 = Response.create(scores:[2,2,1,1], question_ids:[36,37,38,39], survey_id: 10,user_id:user6.id)
	response10= Response.create(scores:[2,2,1,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user6.id)
	response11= Response.create(scores:[3,3,2,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user6.id)

	response1 = Response.create(scores:[3,2,1,0], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user7.id)
	response2 = Response.create(scores:[2,2,1,1], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user7.id)
	response3 = Response.create(scores:[3,2,1,0], question_ids:[9,10,11,12] , survey_id: 3, user_id:user7.id)
	response4 = Response.create(scores:[3,2,2,2], question_ids:[13,14,15,16], survey_id: 4, user_id:user7.id)
	response5 = Response.create(scores:[3,3,2,1], question_ids:[17,18,19,20], survey_id: 5, user_id:user7.id)
	response6 = Response.create(scores:[2,2,0,0], question_ids:[21,22,23,24], survey_id: 6, user_id:user7.id)
	response7 = Response.create(scores:[1,1,1]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user7.id)
	response8 = Response.create(scores:[2,1,1,0], question_ids:[28,29,30,31], survey_id: 8, user_id:user7.id)
	response9 = Response.create(scores:[3,2,2,1], question_ids:[36,37,38,39], survey_id: 10,user_id:user7.id)
	response10= Response.create(scores:[3,2,1,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user7.id)
	response11= Response.create(scores:[3,3,2,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user7.id)

	response1 = Response.create(scores:[2,2,0,0], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user8.id)
	response2 = Response.create(scores:[2,2,0,0], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user8.id)
	response3 = Response.create(scores:[3,2,0,0], question_ids:[9,10,11,12] , survey_id: 3, user_id:user8.id)
	response4 = Response.create(scores:[2,2,2,1], question_ids:[13,14,15,16], survey_id: 4, user_id:user8.id)
	response5 = Response.create(scores:[2,2,2,2], question_ids:[17,18,19,20], survey_id: 5, user_id:user8.id)
	response6 = Response.create(scores:[2,1,1,0], question_ids:[21,22,23,24], survey_id: 6, user_id:user8.id)
	response7 = Response.create(scores:[2,2,2]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user8.id)
	response8 = Response.create(scores:[1,1,1,1], question_ids:[28,29,30,31], survey_id: 8, user_id:user8.id)
	response9 = Response.create(scores:[3,2,2,2], question_ids:[36,37,38,39], survey_id: 10,user_id:user8.id)
	response10= Response.create(scores:[3,3,3,3], question_ids:[40,41,42,43], survey_id: 11,user_id:user8.id)
	response11= Response.create(scores:[3,3,3,3], question_ids:[44,45,46,47], survey_id: 12,user_id:user8.id)

	response1 = Response.create(scores:[3,3,2,2], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user9.id)
	response2 = Response.create(scores:[3,3,2,2], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user9.id)
	response3 = Response.create(scores:[2,1,1,0], question_ids:[9,10,11,12] , survey_id: 3, user_id:user9.id)
	response4 = Response.create(scores:[3,2,2,1], question_ids:[13,14,15,16], survey_id: 4, user_id:user9.id)
	response5 = Response.create(scores:[2,2,2,1], question_ids:[17,18,19,20], survey_id: 5, user_id:user9.id)
	response6 = Response.create(scores:[3,3,2,0], question_ids:[21,22,23,24], survey_id: 6, user_id:user9.id)
	response7 = Response.create(scores:[1,3,0]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user9.id)
	response8 = Response.create(scores:[2,2,2,1], question_ids:[28,29,30,31], survey_id: 8, user_id:user9.id)
	response9 = Response.create(scores:[3,1,1,1], question_ids:[36,37,38,39], survey_id: 10,user_id:user9.id)
	response10= Response.create(scores:[3,2,1,1], question_ids:[40,41,42,43], survey_id: 11,user_id:user9.id)
	response11= Response.create(scores:[3,3,3,2], question_ids:[44,45,46,47], survey_id: 12,user_id:user9.id)

	response1 = Response.create(scores:[2,2,2,0], question_ids:[1,2,3,4]	, survey_id: 1, user_id:user10.id)
	response2 = Response.create(scores:[2,2,1,0], question_ids:[5,6,7,8]	, survey_id: 2, user_id:user10.id)
	response3 = Response.create(scores:[3,2,0,0], question_ids:[9,10,11,12] , survey_id: 3, user_id:user10.id)
	response4 = Response.create(scores:[2,2,0,0], question_ids:[13,14,15,16], survey_id: 4, user_id:user10.id)
	response5 = Response.create(scores:[1,1,1,1], question_ids:[17,18,19,20], survey_id: 5, user_id:user10.id)
	response6 = Response.create(scores:[3,3,3,2], question_ids:[21,22,23,24], survey_id: 6, user_id:user10.id)
	response7 = Response.create(scores:[2,3,1]  , question_ids:[25,26,27]   , survey_id: 7, user_id:user10.id)
	response8 = Response.create(scores:[2,1,2,1], question_ids:[28,29,30,31], survey_id: 8, user_id:user10.id)
	response9 = Response.create(scores:[3,2,1,1], question_ids:[36,37,38,39], survey_id: 10,user_id:user10.id)
	response10= Response.create(scores:[2,2,2,2], question_ids:[40,41,42,43], survey_id: 11,user_id:user10.id)
	response11= Response.create(scores:[3,3,3,1], question_ids:[44,45,46,47], survey_id: 12,user_id:user10.id)


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
