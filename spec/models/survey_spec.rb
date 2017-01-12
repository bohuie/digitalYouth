require 'rails_helper'

describe survey do 
	before { 
		@questions = FactoryGirl.create(:questions)
		@survey = FactoryGirl.create(:survey) 
	
	} 
	subject { @survey }

		it { should respond_to(:question) }

	it { should be_valid }
end