require 'rails_helper'

describe Identity do 
	before { 
		@user = FactoryGirl.create(:user)
		@identity = FactoryGirl.create(:identity, user: @user)
	} 
	subject { @identity }

	it { should respond_to(:user) }
	it { should respond_to(:provider) }
	it { should respond_to(:uid) }

	it { should be_valid }

end
