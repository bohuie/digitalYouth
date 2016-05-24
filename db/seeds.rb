# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[:admin, :employee, :employer].each do |role|
  Role.create({ name: role })
end

user1 = User.create(first_name: 'John', last_name: 'Doe', email: 'john@doe.com', password: 'password', password_confirmation: 'password')
user1.add_role :employee

user2 = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', password_confirmation: 'password', 
	company_name: 'Google', company_address: '123 Fake Street', company_city: 'Kelowna', company_province: 'BC', company_postal_code: 'V1V 1V1')
user2.add_role :employer

user3 = User.create(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
user3.add_role :admin

JobPosting.create(title: 'Social Media Manager', description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: '2016-01-01', close_date: '2016-04-01', user_id: user2.id)

skill1 = Skill.create(name: 'Facebook Posting')
skill2 = Skill.create(name: 'Twitter Posting')
skill3 = Skill.create(name: 'Content Creator')
UserSkill.create(user_id: user1.id, skill_id: skill1.id, rating: "2")


project1 = user1.projects.create(title: 'No Image project', description: 'some description')

ProjectSkill.create(project_id: project1.id, skill_id: skill1.id)
ProjectSkill.create(project_id: project1.id, skill_id: skill2.id)


#Surveys
survey1 = Survey.create(title: 'General'				, category: 'Computer')
survey2 = Survey.create(title: 'Internet and Networks'	, category: 'Computer')
survey3 = Survey.create(title: 'Programming'			, category: 'Computer')
survey4 = Survey.create(title: 'Word Processing'		, category: 'Productivity')
survey5 = Survey.create(title: 'Spreadsheet'			, category: 'Productivity')
survey6 = Survey.create(title: 'Online Communication and Collaboration'	, category: 'Productivity')
survey7 = Survey.create(title: 'Time, Project, People'	, category: 'Management')
survey8 = Survey.create(title: 'Money'					, category: 'Management')
survey9 = Survey.create(title: 'Presentation'			, category: 'Management')
survey10 = Survey.create(title: 'Multimedia'			, category: 'New Media and Personal Qualities')
survey11 = Survey.create(title: 'Social Media'			, category: 'New Media and Personal Qualities')
survey12 = Survey.create(title: '21<sup>st</sup> Century Skills', category: 'New Media and Personal Qualities')

#Survey Questions 
survey_question1 = SurveyQuestion.create(category: 0, survey_id: survey1.id, prompt: 'Start a program')
survey_question2 = SurveyQuestion.create(category: 0, survey_id: survey1.id, prompt: 'Navigate between multiple opened programs')
survey_question3 = SurveyQuestion.create(category: 0, survey_id: survey1.id, prompt: 'Exit a program')
survey_question4 = SurveyQuestion.create(category: 0, survey_id: survey1.id, prompt: 'Use a mouse or track pad')
survey_question5 = SurveyQuestion.create(category: 0, survey_id: survey1.id, prompt: 'Use a keyboard')
survey_question6 = SurveyQuestion.create(category: 0, survey_id: survey1.id, prompt: 'Turn on a computer')
survey_question7 = SurveyQuestion.create(category: 0, survey_id: survey1.id, prompt: 'Shut down a computer')

survey_question8 = SurveyQuestion.create(category: 1, survey_id: survey1.id, prompt: 'Find a program')
survey_question9 = SurveyQuestion.create(category: 1, survey_id: survey1.id, prompt: 'Export a file to a different format')
survey_question10 = SurveyQuestion.create(category: 1, survey_id: survey1.id, prompt: 'Use a webcam')
survey_question11 = SurveyQuestion.create(category: 1, survey_id: survey1.id, prompt: 'Determine the type and version of an operating system')
survey_question12 = SurveyQuestion.create(category: 1, survey_id: survey1.id, prompt: 'Log off a computer')

survey_question13 = SurveyQuestion.create(category: 2, survey_id: survey1.id, prompt: 'Save a file to a flash drive (e.g. USB)')
survey_question14 = SurveyQuestion.create(category: 2, survey_id: survey1.id, prompt: 'Use a microphone')
survey_question15 = SurveyQuestion.create(category: 2, survey_id: survey1.id, prompt: 'Use a scanner')
survey_question16 = SurveyQuestion.create(category: 2, survey_id: survey1.id, prompt: 'Update software')
survey_question17 = SurveyQuestion.create(category: 2, survey_id: survey1.id, prompt: 'Do similar tasks on two different operating systems')

survey_question14 = SurveyQuestion.create(category: 3, survey_id: survey1.id, prompt: 'Save a file to a CD')
survey_question15 = SurveyQuestion.create(category: 3, survey_id: survey1.id, prompt: 'Select software for a defined task')
survey_question16 = SurveyQuestion.create(category: 3, survey_id: survey1.id, prompt: 'Connect a new device (e.g. scanner, mouse, printer, hard drive')
survey_question17 = SurveyQuestion.create(category: 3, survey_id: survey1.id, prompt: 'Install new software (e.g. antivirus)')
survey_question18 = SurveyQuestion.create(category: 3, survey_id: survey1.id, prompt: 'Do similar tasks on at least two operating systems')