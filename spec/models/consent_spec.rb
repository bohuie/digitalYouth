require 'rails_helper'

describe Consent do 
	before { 
		@user = FactoryGirl.create(:user)
		@consent = FactoryGirl.create(:consent, user: @user)
	} 
	subject { @consent }

	it { should respond_to(:user) }
	it { should respond_to(:answer) }
	it { should respond_to(:name) }
	it { should respond_to(:date_signed) }

	it { should be_valid }

end
