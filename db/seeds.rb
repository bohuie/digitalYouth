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

#--- Users for testing ---
user1 = User.new(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'password', password_confirmation: 'password', answered_surveys:[true,true,true,true,true,true,true,true,false,true,true,true])
user1.add_role :employee
user1.skip_confirmation!
user1.save

user2 = User.new(first_name: 'Jane', last_name: 'Doe', email: 'jane@doe.com', password: 'password', password_confirmation: 'password')
user2.add_role :employee
user2.skip_confirmation!
user2.save

user3 = User.new(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', password_confirmation: 'password', 
	company_name: 'Google', company_address: '123 Fake Street', company_city: 'Kelowna', company_province: 'BC', company_postal_code: 'V1V 1V1')
user3.add_role :employer
user3.skip_confirmation!
user3.save

user4 = User.new(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
user4.add_role :admin
user4.skip_confirmation!
user4.save

#Create many random users
#for 0..10 do
#	create_random_user()
#end

#--- References for testing ---
reference1 = Reference.create(first_name: 'Bernie', last_name: 'Smith', email: 'Andrew@gmail.com', company: 'Apple Picking Co.',
			 position: "Lead Apple Picker", phone_number:"(250)555-5555", reference_body: "They were the best Apple Picker.", user_id: user1.id)

reference2 = Reference.create(first_name: 'Bernie', last_name: 'Smith', email: 'Greg@gmail.com', company: 'Apple Pickers United LTD',
			 position: "Apple QC Specialist", phone_number:"(250)555-5050", reference_body: "They were the best.", user_id: user2.id)

#--- JobPostings for testing ---
jobposting1 = JobPosting.create(title: 'Social Media Manager', location: "Kelowna, BC", pay_range: "30¢/hr-40¢/hr", link:"www.google.ca", posted_by:"Seed File",
			  description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: '2016-01-01', close_date: '2016-04-01',
			  job_category_id: 12, user_id: user3.id)

jobposting2 = JobPosting.create(title: 'Social Media Expert', location: "Kelowna, BC", pay_range: "#$30-$40/hr", link:"www.google.ca", posted_by:"Seed File",
			  description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: Date.today-7, close_date: Date.today,
			  job_category_id: 12, user_id: user3.id)

# --- JobPostingApplications for testing ---
jobpostingapplication = JobPostingApplication.create(message: "This is a message", job_posting_id: jobposting1.id, applicant_id: user1.id, company_id: user3.id, status: 0)
jobpostingapplication = JobPostingApplication.create(message: "This be a message", job_posting_id: jobposting1.id, applicant_id: user2.id, company_id: user3.id, status:-2)



#--- Projects for testing ---
project1 = user1.projects.create(title: 'No Image project', description: 'some description')

#--- Survey Responses for testing ---
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


#--- Skills for Testing ---
skill1 = Skill.create(name: 'facebook posting')
skill2 = Skill.create(name: 'twitter posting')
skill3 = Skill.create(name: 'content creator')

UserSkill.create(user_id: user1.id, skill_id: skill1.id, rating: "2")
UserSkill.create(user_id: user1.id, skill_id: skill2.id, rating: "3")

JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill1.id, importance:2, question_id:41)
JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill2.id, importance:2, question_id:42)
JobPostingSkill.create(job_posting_id: jobposting1.id, skill_id:skill3.id, importance:1, question_id:37)

JobPostingSkill.create(job_posting_id: jobposting2.id, skill_id:skill1.id, importance:2, question_id:41)
JobPostingSkill.create(job_posting_id: jobposting2.id, skill_id:skill2.id, importance:2, question_id:42)
JobPostingSkill.create(job_posting_id: jobposting2.id, skill_id:skill3.id, importance:2, question_id:37)

ProjectSkill.create(project_id: project1.id, skill_id: skill1.id)
ProjectSkill.create(project_id: project1.id, skill_id: skill2.id)


#----------- Load Job Posting data from scraping and processing ---------------------
if !Rails.env.test?
	Dir[File.join(Rails.root, 'db', 'scraping', '*.rb')].sort.each { |seed| load seed }
end