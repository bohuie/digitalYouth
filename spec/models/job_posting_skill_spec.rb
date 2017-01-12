require 'rails_helper'

describe JobPostingSkill do 
	before { 
		@survey = FactoryGirl.create(:survey)
		@job_posting = FactoryGirl.create(:job_posting)
		@skill = FactoryGirl.create(:skill)
		@job_posting_skill = FactoryGirl.create(:job_posting_skill, survey: @survey, job_posting: @job_posting, skill: @skill)
	} 
	subject { @job_posting_skill }

	it { should respond_to(:importance) }

	it { should be_valid }

end