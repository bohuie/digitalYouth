require "rails_helper"

describe User do

	context "employee" do

		before { 
			@user = FactoryGirl.create(:user)
		}

		subject { @user }

		it { should respond_to(:first_name) }
		it { should respond_to(:last_name) }
		it { should respond_to(:email) }
		it { should respond_to(:password) }
		it { should respond_to(:github) }
		it { should respond_to(:linkedin) }
		it { should respond_to(:facebook) }
		it { should respond_to(:twitter) }

		it { should be_valid }
	end

	context "employer" do

		before { 
			@user = FactoryGirl.create(:employer)
		}

		subject { @user }

		it { should respond_to(:first_name) }
		it { should respond_to(:last_name) }
		it { should respond_to(:email) }
		it { should respond_to(:password) }
		it { should respond_to(:github) }
		it { should respond_to(:linkedin) }
		it { should respond_to(:facebook) }
		it { should respond_to(:twitter) }
		it { should respond_to(:company_name) }
		it { should respond_to(:company_address) }
		it { should respond_to(:company_city) }
		it { should respond_to(:company_province) }
		it { should respond_to(:company_postal_code) }

		it { should be_valid }

	end
end