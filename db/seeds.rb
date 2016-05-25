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

#Questions
question1 = Question.create(classification: 'Basic'			, survey_id: survey1.id, )
question2 = Question.create(classification: 'Intermediate'	, survey_id: survey1.id, )
question3 = Question.create(classification: 'Advanced'		, survey_id: survey1.id, )
question4 = Question.create(classification: 'Expert'		, survey_id: survey1.id, )

question5 = Question.create(classification: 'Basic'			, survey_id: survey2.id, )
question6 = Question.create(classification: 'Intermediate'	, survey_id: survey2.id, )
question7 = Question.create(classification: 'Advanced'		, survey_id: survey2.id, )
question8 = Question.create(classification: 'Expert'		, survey_id: survey2.id, )

question9 = Question.create(classification: 'Basic'			, survey_id: survey3.id, )
question10 = Question.create(classification: 'Intermediate'	, survey_id: survey3.id, )
question11 = Question.create(classification: 'Advanced'		, survey_id: survey3.id, )
question12 = Question.create(classification: 'Expert'		, survey_id: survey3.id, )

question13 = Question.create(classification: 'Basic'		, survey_id: survey4.id, )
question14 = Question.create(classification: 'Intermediate'	, survey_id: survey4.id, )
question15 = Question.create(classification: 'Advanced'		, survey_id: survey4.id, )
question16 = Question.create(classification: 'Expert'		, survey_id: survey4.id, )

question17 = Question.create(classification: 'Basic'		, survey_id: survey5.id, )
question18 = Question.create(classification: 'Intermediate'	, survey_id: survey5.id, )
question19 = Question.create(classification: 'Advanced'		, survey_id: survey5.id, )
question20 = Question.create(classification: 'Expert'		, survey_id: survey5.id, )

question21 = Question.create(classification: 'Basic'		, survey_id: survey6.id, )
question22 = Question.create(classification: 'Intermediate'	, survey_id: survey6.id, )
question23 = Question.create(classification: 'Advanced'		, survey_id: survey6.id, )
question24 = Question.create(classification: 'Expert'		, survey_id: survey6.id, )

question25 = Question.create(classification: 'Time'			, survey_id: survey7.id, )
question26 = Question.create(classification: 'Project'		, survey_id: survey7.id, )
question27 = Question.create(classification: 'People'		, survey_id: survey7.id, )

question28 = Question.create(classification: 'Basic'		, survey_id: survey8.id, )
question29 = Question.create(classification: 'Intermediate'	, survey_id: survey8.id, )
question30 = Question.create(classification: 'Advanced'		, survey_id: survey8.id, )
question31 = Question.create(classification: 'Expert'		, survey_id: survey8.id, )

question32 = Question.create(classification: 'Basic'		, survey_id: survey9.id, )
question33 = Question.create(classification: 'Intermediate'	, survey_id: survey9.id, )
question34 = Question.create(classification: 'Advanced'		, survey_id: survey9.id, )
question35 = Question.create(classification: 'Expert'		, survey_id: survey9.id, )

question36 = Question.create(classification: 'Basic'		, survey_id: survey10.id, )
question37 = Question.create(classification: 'Intermediate'	, survey_id: survey10.id, )
question38 = Question.create(classification: 'Advanced'		, survey_id: survey10.id, )
question39 = Question.create(classification: 'Expert'		, survey_id: survey10.id, )

question40 = Question.create(classification: 'Basic'		, survey_id: survey11.id, )
question41 = Question.create(classification: 'Intermediate'	, survey_id: survey11.id, )
question42 = Question.create(classification: 'Advanced'		, survey_id: survey11.id, )
question43 = Question.create(classification: 'Expert'		, survey_id: survey11.id, )

question44 = Question.create(classification: 'Basic'		, survey_id: survey12.id, )
question45 = Question.create(classification: 'Intermediate'	, survey_id: survey12.id, )
question46 = Question.create(classification: 'Advanced'		, survey_id: survey12.id, )
question47 = Question.create(classification: 'Expert'		, survey_id: survey12.id, )

#Prompts
prompt1 = Prompt.create(question_id: question1.id, prompt: 'Start a program')
prompt2 = Prompt.create(question_id: question1.id, prompt: 'Navigate between multiple opened programs')
prompt3 = Prompt.create(question_id: question1.id, prompt: 'Exit a program')
prompt4 = Prompt.create(question_id: question1.id, prompt: 'Use a mouse or track pad')
prompt5 = Prompt.create(question_id: question1.id, prompt: 'Use a keyboard')
prompt6 = Prompt.create(question_id: question1.id, prompt: 'Turn on a computer')
prompt7 = Prompt.create(question_id: question1.id, prompt: 'Shut down a computer')

prompt8 = Prompt.create(question_id: question2.id, prompt: 'Find a program')
prompt9 = Prompt.create(question_id: question2.id, prompt: 'Export a file to a different format')
prompt10 = Prompt.create(question_id: question2.id, prompt: 'Use a webcam')
prompt11 = Prompt.create(question_id: question2.id, prompt: 'Determine the type and version of an operating system')
prompt12 = Prompt.create(question_id: question2.id, prompt: 'Log off a computer')

prompt13 = Prompt.create(question_id: question3.id, prompt: 'Save a file to a flash drive (e.g. USB)')
prompt14 = Prompt.create(question_id: question3.id, prompt: 'Use a microphone')
prompt15 = Prompt.create(question_id: question3.id, prompt: 'Use a scanner')
prompt16 = Prompt.create(question_id: question3.id, prompt: 'Update software')
prompt17 = Prompt.create(question_id: question3.id, prompt: 'Do similar tasks on two different operating systems')

prompt14 = Prompt.create(question_id: question4.id, prompt: 'Save a file to a CD')
prompt15 = Prompt.create(question_id: question4.id, prompt: 'Select software for a defined task')
prompt16 = Prompt.create(question_id: question4.id, prompt: 'Connect a new device (e.g. scanner, mouse, printer, hard drive')
prompt17 = Prompt.create(question_id: question4.id, prompt: 'Install new software (e.g. antivirus)')
prompt18 = Prompt.create(question_id: question4.id, prompt: 'Do similar tasks on at least two operating systems')