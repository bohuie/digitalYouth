require 'rails_helper'

describe JobCategory do 
	before { 
		@job_category= FactoryGirl.create(:job_category)
	} 
	subject { @job_category }
	it { should respond_to(:name) }
	it { should respond_to(:job_postings) }

	it { should be_valid }
end