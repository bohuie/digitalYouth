require 'rails_helper'

describe response do 
	
	before { 
		@user = FactoryGirl.create(:user)
		@response = FactoryGirl.create(:response)

	} 
	subject { @question }

		it { should respond_to(:scores) }
		it { should respond_to(:question_ids) }
		it { should respond_to(:survey_id) }

	it { should be_valid }
end