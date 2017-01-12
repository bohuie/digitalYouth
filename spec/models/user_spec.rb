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
		it { should respond_to(:job_postings) }
		it { should respond_to(:projects) }
		it { should respond_to(:references) }
		it { should respond_to(:reference_redirections) }
		it { should respond_to(:responses) }
		it { should respond_to(:job_posting_applications) }
		it { should respond_to(:identities)}

		it { should be_valid }

		describe "when the first_name is not present" do 
			before { @user.first_name = "" }

			it { should_not be_valid }
		end

		describe "when the last_name is not present" do 
			before { @user.last_name = "" }

			it { should_not be_valid }
		end

		describe "when the email is not present" do 
			before { @user.email = "" }

			it { should_not be_valid }
		end

		describe "when the password is not present" do 
			before { @user.password = "" }

			it { should_not be_valid }
		end

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
		it { should respond_to(:linkedin) }
		it { should respond_to(:facebook) }
		it { should respond_to(:twitter) }
		it { should respond_to(:company_name) }
		it { should respond_to(:street_address) }
		it { should respond_to(:city) }
		it { should respond_to(:province) }
		it { should respond_to(:postal_code) }
		it { should respond_to(:job_postings) }
		it { should respond_to(:projects) }
		it { should respond_to(:references) }
		it { should respond_to(:job_posting_applications) }
		it { should respond_to(:identities)}

		it { should be_valid }

		describe "when the first_name is not present" do 
			before {@user.first_name = "" }

			it { should_not be_valid }
		end

		describe "when the last_name is not present" do 
			before {@user.last_name = "" }

			it {should_not be_valid }
		end

		describe "when the email is not present" do 
			before {@user.email = "" }

			it {should_not be_valid }
		end

		describe "when the password is not present" do 
			before {@user.password = ""}

			it {should_not be_valid }
		end

		describe "when the postal_code is not present" do 
			before {@user.postal_code = ""}

			it {should_not be_valid }		
		end
	end
end