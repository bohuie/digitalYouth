require 'rails_helper'

describe question do 
	before { 
		@question = FactoryGirl.create(:question)
		@survey = FactoryGirl.create(:survey) 
		@prompts = FactoryGirl.create(:prompts)
		@responses = FactoryGirl.create(:responses)
	} 
	subject { @question }

		it { should respond_to(:question) }

	it { should be_valid }
end
  