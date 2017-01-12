require 'rails_helper'

describe JobPostingApplication do 
	before { 
		@user = FactoryGirl.create(:user)
		@company = FactoryGirl.create(:employer)
		@job_posting = FactoryGirl.create(:job_posting)
		@job_posting_application= FactoryGirl.create(:job_posting_application, applicant: @user, company:@company)
	
	}
	subject { @job_posting_application }

	it { should respond_to(:message) }
	

	it { should be_valid }
end