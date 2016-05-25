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

question44 = Question.create(classification: 'Communication'		, survey_id: survey12.id, )
question45 = Question.create(classification: 'Problem Solving'	, survey_id: survey12.id, )
question46 = Question.create(classification: 'Advanced'		, survey_id: survey12.id, )
question47 = Question.create(classification: 'Self-Directed Skill'		, survey_id: survey12.id, )

#Prompts
#Survey 1:
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

#Survey 2:
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

#Survey 3:
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

#Survey 4:
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

#Survey 5:
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

#Survey 6:
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

#Template
#survey#_prompt# = Prompt.create(question_id: question#.id, prompt: '')