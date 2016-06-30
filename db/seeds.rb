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
user1.confirm

user4 = User.create(first_name: 'Jane', last_name: 'Doe', email: 'jane@doe.com', password: 'password', password_confirmation: 'password')
user4.add_role :employee
user4.confirm

for i in 0..20
	Reference.create(first_name: 'Andrew'+i.to_s, last_name: 'Smith', email: 'Andrew@gmail.com', company: 'Apple Picking Co.',
		position: "Lead Apple Picker", phone_number:"(250)555-5555", reference_body: "They were the best Apple Picker.", user_id: user1.id)
end

reference1 = Reference.create(first_name: 'Bernie', last_name: 'Smith', email: 'Andrew@gmail.com', company: 'Apple Picking Co.',
			 position: "Lead Apple Picker", phone_number:"(250)555-5555", reference_body: "They were the best Apple Picker.", user_id: user4.id)


user2 = User.create(first_name: 'Foo', last_name: 'Bar', email: 'foo@bar.com', password: 'password', password_confirmation: 'password', 
	company_name: 'Google', company_address: '123 Fake Street', company_city: 'Kelowna', company_province: 'BC', company_postal_code: 'V1V 1V1')
user2.add_role :employer
user2.confirm

user3 = User.create(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password: 'password', password_confirmation: 'password')
user3.add_role :admin
user3.confirm

skill1 = Skill.create(name: 'Facebook Posting', question_id:22)
skill2 = Skill.create(name: 'Twitter Posting', question_id:23)
skill3 = Skill.create(name: 'Content Creator', question_id:41)
UserSkill.create(user_id: user1.id, skill_id: skill1.id, rating: "2")

job = JobPosting.create(title: 'Social Media Manager', location: "Kelowna, British Columbia", pay_range: "30¢/hr-40¢/hr", link:"google.ca", posted_by:"Seed File", description: 'Handling our Facebook and Twitter account, posting messages, and responding to clients.', open_date: '2016-01-01', close_date: '2016-04-01', user_id: user2.id)
JobPostingSkill.create(job_posting_id: job.id, skill_id:skill1.id, importance:2)
JobPostingSkill.create(job_posting_id: job.id, skill_id:skill2.id, importance:2)
JobPostingSkill.create(job_posting_id: job.id, skill_id:skill3.id, importance:1)

project1 = user1.projects.create(title: 'No Image project', description: 'some description')

ProjectSkill.create(project_id: project1.id, skill_id: skill1.id)
ProjectSkill.create(project_id: project1.id, skill_id: skill2.id)



# ---- Surveys ----

#Surveys - title and category
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
survey12 = Survey.create(title: '21st Century Skills'	, category: 'New Media and Personal Qualities')

#Questions - These are essentially the labels for each question
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

question44 = Question.create(classification: 'Communication'		, survey_id: survey12.id, )
question45 = Question.create(classification: 'Problem Solving'		, survey_id: survey12.id, )
question46 = Question.create(classification: 'Self-Directed Skill'				, survey_id: survey12.id, )
question47 = Question.create(classification: 'Accountability'	, survey_id: survey12.id, )

#Prompts
#Survey 1: General
survey1_prompt1 = Prompt.create(question_id: question1.id, prompt: 'Start a program')
survey1_prompt2 = Prompt.create(question_id: question1.id, prompt: 'Navigate between multiple opened programs')
survey1_prompt3 = Prompt.create(question_id: question1.id, prompt: 'Exit a program')
survey1_prompt4 = Prompt.create(question_id: question1.id, prompt: 'Use a mouse or track pad')
survey1_prompt5 = Prompt.create(question_id: question1.id, prompt: 'Use a keyboard')
survey1_prompt6 = Prompt.create(question_id: question1.id, prompt: 'Turn on a computer')
survey1_prompt7 = Prompt.create(question_id: question1.id, prompt: 'Shut down a computer')

survey1_prompt8 = Prompt.create(question_id: question2.id, prompt: 'Find a program')
survey1_prompt9 = Prompt.create(question_id: question2.id, prompt: 'Export a file to a different format')
survey1_prompt10 = Prompt.create(question_id: question2.id, prompt: 'Use a webcam')
survey1_prompt11 = Prompt.create(question_id: question2.id, prompt: 'Determine the type and version of an operating system')
survey1_prompt12 = Prompt.create(question_id: question2.id, prompt: 'Log off a computer')

survey1_prompt13 = Prompt.create(question_id: question3.id, prompt: 'Save a file to a flash drive (e.g. USB)')
survey1_prompt14 = Prompt.create(question_id: question3.id, prompt: 'Use a microphone')
survey1_prompt15 = Prompt.create(question_id: question3.id, prompt: 'Use a scanner')
survey1_prompt16 = Prompt.create(question_id: question3.id, prompt: 'Update software')
survey1_prompt17 = Prompt.create(question_id: question3.id, prompt: 'Do similar tasks on two different operating systems')

survey1_prompt14 = Prompt.create(question_id: question4.id, prompt: 'Save a file to a CD')
survey1_prompt15 = Prompt.create(question_id: question4.id, prompt: 'Select software for a defined task')
survey1_prompt16 = Prompt.create(question_id: question4.id, prompt: 'Connect a new device (e.g. scanner, mouse, printer, hard drive')
survey1_prompt17 = Prompt.create(question_id: question4.id, prompt: 'Install new software (e.g. antivirus)')
survey1_prompt18 = Prompt.create(question_id: question4.id, prompt: 'Do similar tasks on at least two operating systems')

#Survey 2: Internet and Networks
survey2_prompt1 = Prompt.create(question_id: question5.id, prompt: 'Open a browser')
survey2_prompt2 = Prompt.create(question_id: question5.id, prompt: 'Determine the url (web address) of a website')
survey2_prompt3 = Prompt.create(question_id: question5.id, prompt: 'Go to a website')
survey2_prompt4 = Prompt.create(question_id: question5.id, prompt: 'Follow links on a webpage')
survey2_prompt5 = Prompt.create(question_id: question5.id, prompt: 'Print a webpage')

survey2_prompt6 = Prompt.create(question_id: question6.id, prompt: 'Use a browser to move forward and backward through webpages')
survey2_prompt7 = Prompt.create(question_id: question6.id, prompt: 'Use a browser to refresh/reload a webpage')
survey2_prompt8 = Prompt.create(question_id: question6.id, prompt: 'Save a website as a bookmark or favourites')
survey2_prompt9 = Prompt.create(question_id: question6.id, prompt: 'Download files from the internet')
survey2_prompt10 = Prompt.create(question_id: question6.id, prompt: 'Install software from the internet')
survey2_prompt11 = Prompt.create(question_id: question6.id, prompt: 'Check if the computer is connected to the internet')
survey2_prompt12 = Prompt.create(question_id: question6.id, prompt: 'Connect to an (un)secured wireless connection')

survey2_prompt13 = Prompt.create(question_id: question7.id, prompt: 'Determine the domain name of a website')
survey2_prompt14 = Prompt.create(question_id: question7.id, prompt: 'Use search engines (e.g. Google, Yahoo!')
survey2_prompt15 = Prompt.create(question_id: question7.id, prompt: 'Use advanced search filters and strategies')
survey2_prompt16 = Prompt.create(question_id: question7.id, prompt: 'Connect to the internet using a cable')
survey2_prompt17 = Prompt.create(question_id: question7.id, prompt: 'Determine the IP address of a machine')

survey2_prompt14 = Prompt.create(question_id: question8.id, prompt: 'Connect to a modem')
survey2_prompt15 = Prompt.create(question_id: question8.id, prompt: 'Configure a modem')
survey2_prompt16 = Prompt.create(question_id: question8.id, prompt: 'Connect to a wireless router')
survey2_prompt17 = Prompt.create(question_id: question8.id, prompt: 'Configure a wireless router')
survey2_prompt18 = Prompt.create(question_id: question8.id, prompt: 'Check activity status of a specific server')
survey2_prompt19 = Prompt.create(question_id: question8.id, prompt: 'Troubleshoot network connectivity problems')

#Survey 3: Programming
survey3_prompt1 = Prompt.create(question_id: question9.id, prompt: 'Use tools and templates to create websites')
survey3_prompt2 = Prompt.create(question_id: question9.id, prompt: 'Modify basic HTML code or code in other markup languages')
survey3_prompt3 = Prompt.create(question_id: question9.id, prompt: 'Modify simple CSS elements')
survey3_prompt4 = Prompt.create(question_id: question9.id, prompt: 'Understand basic concepts in computer programming')

survey3_prompt5 = Prompt.create(question_id: question10.id, prompt: 'Build simple websites from scratch')
survey3_prompt6 = Prompt.create(question_id: question10.id, prompt: 'Write and test programs to do mathematical calculations')
survey3_prompt7 = Prompt.create(question_id: question10.id, prompt: 'Write and test programs that read from and write to files')
survey3_prompt8 = Prompt.create(question_id: question10.id, prompt: 'Write and test programs that use elementary data structures such as arrays and linked lists')

survey3_prompt9 = Prompt.create(question_id: question11.id, prompt: 'Write and test programs that use complex data structures such as hash maps and trees')
survey3_prompt10 = Prompt.create(question_id: question11.id, prompt: 'Write and test programs that have a graphical user interface')
survey3_prompt11 = Prompt.create(question_id: question11.id, prompt: 'Write and test simple apps for mobile devices')
survey3_prompt12 = Prompt.create(question_id: question11.id, prompt: 'Measure programs for performance')

survey3_prompt13 = Prompt.create(question_id: question12.id, prompt: 'Build complex websites with databases and modern interface')
survey3_prompt14 = Prompt.create(question_id: question12.id, prompt: 'Write and test programs that mimics mathematical models')
survey3_prompt15 = Prompt.create(question_id: question12.id, prompt: 'Write and test programs to run simulations and experiments')
survey3_prompt16 = Prompt.create(question_id: question12.id, prompt: 'Write and test third party apps for social media platform')
survey3_prompt17 = Prompt.create(question_id: question12.id, prompt: 'Optimize programs for performance')

#Survey 4: Word Processing
survey4_prompt1 = Prompt.create(question_id: question13.id, prompt: 'Open a new document')
survey4_prompt2 = Prompt.create(question_id: question13.id, prompt: 'Edit a document')
survey4_prompt3 = Prompt.create(question_id: question13.id, prompt: 'Save a document')
survey4_prompt4 = Prompt.create(question_id: question13.id, prompt: 'Cut/copy/paste content')
survey4_prompt5 = Prompt.create(question_id: question13.id, prompt: 'Close a document')
survey4_prompt6 = Prompt.create(question_id: question13.id, prompt: 'Switch to another opened document')
survey4_prompt7 = Prompt.create(question_id: question13.id, prompt: 'Zoom in and out')

survey4_prompt8 = Prompt.create(question_id: question14.id, prompt: 'Create section headings')
survey4_prompt9 = Prompt.create(question_id: question14.id, prompt: 'Create title pages and table of contents')
survey4_prompt10 = Prompt.create(question_id: question14.id, prompt: 'Adjust text stylizations and spacing')
survey4_prompt11 = Prompt.create(question_id: question14.id, prompt: 'Create bullet lists')
survey4_prompt12 = Prompt.create(question_id: question14.id, prompt: 'Create tables')
survey4_prompt13 = Prompt.create(question_id: question14.id, prompt: 'Insert images')

survey4_prompt9 = Prompt.create(question_id: question15.id, prompt: 'Use a template')
survey4_prompt10 = Prompt.create(question_id: question15.id, prompt: 'Modify paragraph spacing')
survey4_prompt11 = Prompt.create(question_id: question15.id, prompt: 'Set document margins')
survey4_prompt12 = Prompt.create(question_id: question15.id, prompt: 'Change page orientation')
survey4_prompt13 = Prompt.create(question_id: question15.id, prompt: 'Add header and footer content')
survey4_prompt14 = Prompt.create(question_id: question15.id, prompt: 'Add captions to images and tables')

survey4_prompt15 = Prompt.create(question_id: question16.id, prompt: 'Spell check the document')
survey4_prompt16 = Prompt.create(question_id: question16.id, prompt: 'Grammar check the document')
survey4_prompt17 = Prompt.create(question_id: question16.id, prompt: 'Check word count of highlighted text')
survey4_prompt18 = Prompt.create(question_id: question16.id, prompt: 'Add comments to a document')
survey4_prompt19 = Prompt.create(question_id: question16.id, prompt: 'Use "review mode" to highlight contributions made by different users')

#Survey 5: Spreadsheet
survey5_prompt1 = Prompt.create(question_id: question17.id, prompt: 'Open a new spreadsheet')
survey5_prompt2 = Prompt.create(question_id: question17.id, prompt: 'Edit a spreadsheet')
survey5_prompt3 = Prompt.create(question_id: question17.id, prompt: 'Save a spreadsheet')
survey5_prompt4 = Prompt.create(question_id: question17.id, prompt: 'Cut/copy/paste cells')
survey5_prompt5 = Prompt.create(question_id: question17.id, prompt: 'Close a spreadsheet')
survey5_prompt6 = Prompt.create(question_id: question17.id, prompt: 'Switch to another opened spreadsheet')
survey5_prompt7 = Prompt.create(question_id: question17.id, prompt: 'Zoom in and out')

survey5_prompt8 = Prompt.create(question_id: question18.id, prompt: 'Create multiple sheets within one document')
survey5_prompt9 = Prompt.create(question_id: question18.id, prompt: 'Adjust text stylizations and spacing')
survey5_prompt10 = Prompt.create(question_id: question18.id, prompt: 'Format cells')
survey5_prompt11 = Prompt.create(question_id: question18.id, prompt: 'Insert Images')
survey5_prompt12 = Prompt.create(question_id: question18.id, prompt: 'Cut/copy/paste columns')

survey5_prompt13 = Prompt.create(question_id: question19.id, prompt: 'Use a template')
survey5_prompt14 = Prompt.create(question_id: question19.id, prompt: 'Find and use formulas')
survey5_prompt15 = Prompt.create(question_id: question19.id, prompt: 'Create equations')
survey5_prompt16 = Prompt.create(question_id: question19.id, prompt: '(Un)hide rows')
survey5_prompt17 = Prompt.create(question_id: question19.id, prompt: 'Sort information')
survey5_prompt18 = Prompt.create(question_id: question19.id, prompt: 'Reference cells in a different sheet')

survey5_prompt19 = Prompt.create(question_id: question20.id, prompt: 'Freeze panes')
survey5_prompt20 = Prompt.create(question_id: question20.id, prompt: 'Create charts')
survey5_prompt21 = Prompt.create(question_id: question20.id, prompt: 'Calculate basic statistics (e.g. sum, average, histogram)')
survey5_prompt22 = Prompt.create(question_id: question20.id, prompt: 'Creating macros')
survey5_prompt23 = Prompt.create(question_id: question20.id, prompt: 'Writing VBA to define specialized functions')

#Survey 6: Online communication and collab
survey6_prompt1 = Prompt.create(question_id: question21.id, prompt: 'Read emails')
survey6_prompt2 = Prompt.create(question_id: question21.id, prompt: 'Compose new emails')
survey6_prompt3 = Prompt.create(question_id: question21.id, prompt: 'Send, reply, and forward emails')
survey6_prompt4 = Prompt.create(question_id: question21.id, prompt: 'Attend and online meeting')
survey6_prompt5 = Prompt.create(question_id: question21.id, prompt: 'Edit documents online')

survey6_prompt6 = Prompt.create(question_id: question22.id, prompt: 'Carbon copy additional recipients in an email')
survey6_prompt7 = Prompt.create(question_id: question22.id, prompt: 'Create and activate a new email account')
survey6_prompt8 = Prompt.create(question_id: question22.id, prompt: 'Manage an account using folders')
survey6_prompt9 = Prompt.create(question_id: question22.id, prompt: 'Send emails with attachments')
survey6_prompt10 = Prompt.create(question_id: question22.id, prompt: 'Share documents online')

survey6_prompt11 = Prompt.create(question_id: question23.id, prompt: 'Reset an account password')
survey6_prompt11 = Prompt.create(question_id: question23.id, prompt: 'Flag an email as important')
survey6_prompt13 = Prompt.create(question_id: question23.id, prompt: 'Request email client to notify you (the sender) when a respondent has read your email')
survey6_prompt14 = Prompt.create(question_id: question23.id, prompt: 'Email a meeting request with a calender')
survey6_prompt15 = Prompt.create(question_id: question23.id, prompt: 'Establish video conference calls (with multiple parties)')

survey6_prompt16 = Prompt.create(question_id: question24.id, prompt: 'Set up POP/IMAP to synchronize emails accross different computers/devices')
survey6_prompt17 = Prompt.create(question_id: question24.id, prompt: 'Organize an online event')
survey6_prompt18 = Prompt.create(question_id: question24.id, prompt: 'Pool participant available times together')
survey6_prompt19 = Prompt.create(question_id: question24.id, prompt: 'Use an online tool to schedule an event')

#Survey 7: Time, Project, People
survey7_prompt1 = Prompt.create(question_id: question25.id, prompt: 'When working in a group, I ensure we use our time productively')
survey7_prompt2 = Prompt.create(question_id: question25.id, prompt: 'I use tools (e.g. to-do lists, activity log) to improve my time management')
survey7_prompt3 = Prompt.create(question_id: question25.id, prompt: 'I distinguish tasks with different level of priorites')
survey7_prompt4 = Prompt.create(question_id: question25.id, prompt: 'I make plans and set goals each day')
survey7_prompt5 = Prompt.create(question_id: question25.id, prompt: 'I follow my plan of actions whenever possible')
survey7_prompt6 = Prompt.create(question_id: question25.id, prompt: 'I avoid procrastination even when the task is vague or unpleasant')

survey7_prompt7 = Prompt.create(question_id: question26.id, prompt: 'Given a project, I can develop a detailed plan (e.g. a work breakdown structure) with achievable milestones and set resources')
survey7_prompt8 = Prompt.create(question_id: question26.id, prompt: 'Given specific project requirements, I can design various solutions that can meet the client\'s needs')
survey7_prompt9 = Prompt.create(question_id: question26.id, prompt: 'In a project, I can lead the team effectively to meet the target milestones and goals')
survey7_prompt10 = Prompt.create(question_id: question26.id, prompt: 'When working on a project, I reflect on past experiences (successes, challenges, and failures) and use them to plan future actions')
survey7_prompt11 = Prompt.create(question_id: question26.id, prompt: 'Over the course of the project, I use quantitative metrics as well as qualitative feedback to monitor progress')
survey7_prompt12 = Prompt.create(question_id: question26.id, prompt: 'At the end of a project, I am able to identify successes, challenges, and failures, and explain them with quantitative ')

survey7_prompt13 = Prompt.create(question_id: question27.id, prompt: 'I listen to others and am receptive to their ideas')
survey7_prompt14 = Prompt.create(question_id: question27.id, prompt: 'I consider\'s needs and priorities')
survey7_prompt15 = Prompt.create(question_id: question27.id, prompt: 'When working in a group, I ensure everyone has an opportunity to contribute')
survey7_prompt16 = Prompt.create(question_id: question27.id, prompt: 'I am aware of other\'s emotions, perspectives, and behaviours when in a group')
survey7_prompt17 = Prompt.create(question_id: question27.id, prompt: 'I am always involved in group tasks and discussions')
survey7_prompt18 = Prompt.create(question_id: question27.id, prompt: 'I can manage conflict with group members effectively')
survey7_prompt19 = Prompt.create(question_id: question27.id, prompt: 'When working in a group, I am able to discuss and reach a consensus when a decision has to be made')

#Survey 8: Money 
survey8_prompt1 = Prompt.create(question_id: question28.id, prompt: 'Develop budget proposals')
survey8_prompt2 = Prompt.create(question_id: question28.id, prompt: 'Understand financial charts')
survey8_prompt3 = Prompt.create(question_id: question28.id, prompt: 'Recognition of revenues and costs')
survey8_prompt4 = Prompt.create(question_id: question28.id, prompt: 'Keep the team informed')
survey8_prompt5 = Prompt.create(question_id: question28.id, prompt: 'Manage project Scope')

survey8_prompt6 = Prompt.create(question_id: question29.id, prompt: 'Develop budget strategies')
survey8_prompt7 = Prompt.create(question_id: question29.id, prompt: 'Create profit and loss statement')
survey8_prompt8 = Prompt.create(question_id: question29.id, prompt: 'Create balance sheet and cash flow statement')
survey8_prompt9 = Prompt.create(question_id: question29.id, prompt: 'Apply methods to measure inventory, accounts, receivable, accounts payable')
survey8_prompt10 = Prompt.create(question_id: question29.id, prompt: 'Identify relevant costs for pricing')

survey8_prompt11 = Prompt.create(question_id: question30.id, prompt: 'Apply methods to reduce inventory, accounts receivable, and keep capital expenditure under control')
survey8_prompt12 = Prompt.create(question_id: question30.id, prompt: 'Understand and manage types of investments and costs for investment decisions')
survey8_prompt13 = Prompt.create(question_id: question30.id, prompt: 'Compare different pricing techniques')
survey8_prompt14 = Prompt.create(question_id: question30.id, prompt: 'Calculate breakeven point')
survey8_prompt15 = Prompt.create(question_id: question30.id, prompt: 'Conduct budget variation analysis')

survey8_prompt16 = Prompt.create(question_id: question31.id, prompt: 'Develop pricing strategies')
survey8_prompt17 = Prompt.create(question_id: question31.id, prompt: 'Forecast the budget')
survey8_prompt18 = Prompt.create(question_id: question31.id, prompt: 'Forecast resource usage')
survey8_prompt19 = Prompt.create(question_id: question31.id, prompt: 'Create simulations to demonstrate scenarios')
survey8_prompt20 = Prompt.create(question_id: question31.id, prompt: 'Plan organization\'s short and long term financial goals')

#Survey 9: - Presentation
survey9_prompt1 = Prompt.create(question_id: question32.id, prompt: 'Open a new presentation document')
survey9_prompt2 = Prompt.create(question_id: question32.id, prompt: 'Edit a document')
survey9_prompt3 = Prompt.create(question_id: question32.id, prompt: 'Save a document')
survey9_prompt4 = Prompt.create(question_id: question32.id, prompt: 'Cut/copy/paste content')
survey9_prompt5 = Prompt.create(question_id: question32.id, prompt: 'Close a document')
survey9_prompt6 = Prompt.create(question_id: question32.id, prompt: 'Switch to another opened document')
survey9_prompt7 = Prompt.create(question_id: question32.id, prompt: 'Zoom in and out')
survey9_prompt8 = Prompt.create(question_id: question32.id, prompt: 'Switch between presentation and edit mode')

survey9_prompt9 = Prompt.create(question_id: question33.id, prompt: 'Add notes to a slide')
survey9_prompt10 = Prompt.create(question_id: question33.id, prompt: 'Incorporate images')
survey9_prompt11 = Prompt.create(question_id: question33.id, prompt: 'Incorporate audio files')
survey9_prompt12 = Prompt.create(question_id: question33.id, prompt: 'Incorporate video clips')
survey9_prompt13 = Prompt.create(question_id: question33.id, prompt: 'Adjust text stylizations and spacing')
survey9_prompt14 = Prompt.create(question_id: question33.id, prompt: 'Create tables')
survey9_prompt15 = Prompt.create(question_id: question33.id, prompt: 'Add page numbers')

survey9_prompt16 = Prompt.create(question_id: question34.id, prompt: 'Use a template')
survey9_prompt17 = Prompt.create(question_id: question34.id, prompt: 'Change the layout of the slide')
survey9_prompt18 = Prompt.create(question_id: question34.id, prompt: 'Use animations')
survey9_prompt19 = Prompt.create(question_id: question34.id, prompt: 'Use transitions')
survey9_prompt20 = Prompt.create(question_id: question34.id, prompt: 'Change footers')

survey9_prompt21 = Prompt.create(question_id: question35.id, prompt: 'Change template style')
survey9_prompt22 = Prompt.create(question_id: question35.id, prompt: 'Create new template styles')
survey9_prompt23 = Prompt.create(question_id: question35.id, prompt: 'Create a timed slideshow')
survey9_prompt24 = Prompt.create(question_id: question35.id, prompt: 'Add music to a slideshow')
survey9_prompt25 = Prompt.create(question_id: question35.id, prompt: 'Record and incorporate audio')
survey9_prompt26 = Prompt.create(question_id: question35.id, prompt: 'Create and incorporate charts and graphs')

#Survey 10: Multimedia 
survey10_prompt1 = Prompt.create(question_id: question36.id, prompt: 'Listen to music on a CD')
survey10_prompt2 = Prompt.create(question_id: question36.id, prompt: 'Listen to music on a mobile device (e.g. phone or tablet)')
survey10_prompt3 = Prompt.create(question_id: question36.id, prompt: 'Watch a movie on a DVD')
survey10_prompt4 = Prompt.create(question_id: question36.id, prompt: 'Watch a movie on a mobile device')
survey10_prompt5 = Prompt.create(question_id: question36.id, prompt: 'View photos')
survey10_prompt6 = Prompt.create(question_id: question36.id, prompt: 'Take photos using a digital camera or phone')

survey10_prompt7 = Prompt.create(question_id: question37.id, prompt: 'Take a video using a digital camera or phone')
survey10_prompt8 = Prompt.create(question_id: question37.id, prompt: 'Search for images, music, and movies of interest')
survey10_prompt9 = Prompt.create(question_id: question37.id, prompt: 'Trim media (e.g. image, audio, video) content')
survey10_prompt10 = Prompt.create(question_id: question37.id, prompt: 'Combine two files together')
survey10_prompt11 = Prompt.create(question_id: question37.id, prompt: 'Add text and subtitles to the media')
survey10_prompt12 = Prompt.create(question_id: question37.id, prompt: 'Edit a media file without changing the original work much')

survey10_prompt13 = Prompt.create(question_id: question38.id, prompt: 'Create a new media file')
survey10_prompt14 = Prompt.create(question_id: question38.id, prompt: 'Apply filters to manipulate the original media')
survey10_prompt15 = Prompt.create(question_id: question38.id, prompt: 'Use layers to control different changes made to a file')
survey10_prompt16 = Prompt.create(question_id: question38.id, prompt: 'Edit the media file in more complex ways')
survey10_prompt17 = Prompt.create(question_id: question38.id, prompt: 'Transfer media files across multiple devices')

survey10_prompt19 = Prompt.create(question_id: question39.id, prompt: 'Create infographics')
survey10_prompt20 = Prompt.create(question_id: question39.id, prompt: 'Create animated gifs')
survey10_prompt21 = Prompt.create(question_id: question39.id, prompt: 'Browse and purchase media repositories')
survey10_prompt22 = Prompt.create(question_id: question39.id, prompt: 'Determine the copyrights of a media file')
survey10_prompt23 = Prompt.create(question_id: question39.id, prompt: 'Determine if a media file has been manipulated')
survey10_prompt24 = Prompt.create(question_id: question39.id, prompt: 'Identify the specific parts of a media file that has been manipulated')

#Survey 11: Social Media 
survey11_prompt1 = Prompt.create(question_id: question40.id, prompt: 'Read posts')
survey11_prompt2 = Prompt.create(question_id: question40.id, prompt: 'Post updates')
survey11_prompt3 = Prompt.create(question_id: question40.id, prompt: 'Respond to comments')
survey11_prompt4 = Prompt.create(question_id: question40.id, prompt: 'Post pictures and videos')
survey11_prompt5 = Prompt.create(question_id: question40.id, prompt: 'Blog')
survey11_prompt6 = Prompt.create(question_id: question40.id, prompt: 'Comment on blogs or other content')
survey11_prompt7 = Prompt.create(question_id: question40.id, prompt: 'Like/favourite content')
survey11_prompt8 = Prompt.create(question_id: question40.id, prompt: 'Share and curate content')
survey11_prompt9 = Prompt.create(question_id: question40.id, prompt: 'Network with others')

survey11_prompt10 = Prompt.create(question_id: question41.id, prompt: 'Create social media accounts')
survey11_prompt11 = Prompt.create(question_id: question41.id, prompt: 'Update account')
survey11_prompt12 = Prompt.create(question_id: question41.id, prompt: 'Tag pictures and videos')
survey11_prompt13 = Prompt.create(question_id: question41.id, prompt: 'Create a blog')
survey11_prompt14 = Prompt.create(question_id: question41.id, prompt: 'Follow others')
survey11_prompt15 = Prompt.create(question_id: question41.id, prompt: 'Subscribe to groups and forums')
survey11_prompt16 = Prompt.create(question_id: question41.id, prompt: 'Check news updates')
survey11_prompt17 = Prompt.create(question_id: question41.id, prompt: 'Participate in online question and answering forums')

survey11_prompt18 = Prompt.create(question_id: question42.id, prompt: 'Create public forum on specific topics')
survey11_prompt19 = Prompt.create(question_id: question42.id, prompt: 'Solicit user feedback')
survey11_prompt20 = Prompt.create(question_id: question42.id, prompt: 'Develop text content for social media')
survey11_prompt21 = Prompt.create(question_id: question42.id, prompt: 'Develop images/video content for social media')
survey11_prompt22 = Prompt.create(question_id: question42.id, prompt: 'Engage others using social media')
survey11_prompt23 = Prompt.create(question_id: question42.id, prompt: 'Check up on competitors')
survey11_prompt24 = Prompt.create(question_id: question42.id, prompt: 'Use tools to manage multiple channels (e.g. Hootsuite)')

survey11_prompt25 = Prompt.create(question_id: question43.id, prompt: 'Moderate forums and disussions')
survey11_prompt26 = Prompt.create(question_id: question43.id, prompt: 'Incorporate social media as part of a larger campaign')
survey11_prompt27 = Prompt.create(question_id: question43.id, prompt: 'Develop social media plan according to business objectives')
survey11_prompt28 = Prompt.create(question_id: question43.id, prompt: 'Buy paid ads')
survey11_prompt29 = Prompt.create(question_id: question43.id, prompt: 'Actively acquire followers')
survey11_prompt30 = Prompt.create(question_id: question43.id, prompt: 'Collect data')
survey11_prompt31 = Prompt.create(question_id: question43.id, prompt: 'Use tools to view trends and analytics')
survey11_prompt32 = Prompt.create(question_id: question43.id, prompt: 'Organize events/petitons/groups')

#Survey 12: 21st Century Skills 
survey12_prompt1 = Prompt.create(question_id: question44.id, prompt: 'I use language in meaningful ways to inspire, entertain, inform, and persuade others')
survey12_prompt2 = Prompt.create(question_id: question44.id, prompt: 'I think about who my audience is when I communicate and adjust my vocabulary accordingly')
survey12_prompt3 = Prompt.create(question_id: question44.id, prompt: 'I listen actvely to others')
survey12_prompt4 = Prompt.create(question_id: question44.id, prompt: 'When speaking with other people, I think about areas of agreement as well as disagreement')
survey12_prompt5 = Prompt.create(question_id: question44.id, prompt: 'I respect others\' ideas even if I disagree with them')
survey12_prompt6 = Prompt.create(question_id: question44.id, prompt: 'I communicate my ideas effectively and explain my opinions clearly')
survey12_prompt7 = Prompt.create(question_id: question44.id, prompt: 'I support my opinions with credible evidence')

survey12_prompt8 = Prompt.create(question_id: question45.id, prompt: 'I recognize that large problems or projects may not have clear or simple solutions')
survey12_prompt9 = Prompt.create(question_id: question45.id, prompt: 'When I do not solve a problem right away, I take a different perspective and try again')
survey12_prompt10 = Prompt.create(question_id: question45.id, prompt: 'I can think of lots of new ideas to solve the same problem')
survey12_prompt11 = Prompt.create(question_id: question45.id, prompt: 'I prefer working with others because exchanging ideas helps me think of more ideas')
survey12_prompt12 = Prompt.create(question_id: question45.id, prompt: 'I look at situations and processes from a variety of viewpoints in order to indentify problems')
survey12_prompt13 = Prompt.create(question_id: question45.id, prompt: 'I evaluate all possible solutions using criteria of practicality, efficiency, and elegance to choose the best solution')
survey12_prompt14 = Prompt.create(question_id: question45.id, prompt: 'I think ahead in a project to anticipate and avoid possible problems')

survey12_prompt15 = Prompt.create(question_id: question46.id, prompt: 'I set goals independently')
survey12_prompt16 = Prompt.create(question_id: question46.id, prompt: 'I can organize competing priorites')
survey12_prompt17 = Prompt.create(question_id: question46.id, prompt: 'I persevere when things are tough')
survey12_prompt18 = Prompt.create(question_id: question46.id, prompt: 'I ask others for feedback and advice')
survey12_prompt19 = Prompt.create(question_id: question46.id, prompt: 'I consider others\' ideas seriously in thinking about my own work')
survey12_prompt20 = Prompt.create(question_id: question46.id, prompt: 'I seek out new experiences without worrying about what others think of me or whether I\'ll make mistakes')
survey12_prompt21 = Prompt.create(question_id: question46.id, prompt: 'I am willing to voice and support an opinion even if it wil be unpopular with my peers')

survey12_prompt22 = Prompt.create(question_id: question47.id, prompt: 'I am always punctual with good attendance')
survey12_prompt23 = Prompt.create(question_id: question47.id, prompt: 'I always think of questions to ask and do so when appropriate')
survey12_prompt24 = Prompt.create(question_id: question47.id, prompt: 'I carry myself in a professional manner')
survey12_prompt25 = Prompt.create(question_id: question47.id, prompt: 'I consistently manage time and resources in an efficient manner to achieve what I need to get done')
survey12_prompt26 = Prompt.create(question_id: question47.id, prompt: 'I use a variety of tools and techniques')
survey12_prompt27 = Prompt.create(question_id: question47.id, prompt: 'I always communicate with my coworkers if I run into problems')

#---- Template ----
##Survey #: Title 
#survey#_prompt# = Prompt.create(question_id: question#.id, prompt: '')