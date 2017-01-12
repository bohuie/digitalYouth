require 'rails_helper'

describe prompt do 
	before { 
		@question = FactoryGirl.create(:question)
	} 
	subject { @prompt }

		it { should respond_to(:prompt) }

	it { should be_valid }
end
  