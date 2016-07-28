require 'rails_helper'

RSpec.describe JobPostingApplicationsController, type: :controller do

	describe "GET index" do
		context "employer is logged in" do
			before(:each) do
				
			end	

			it "loads the job posting applications that aren't deleted" do
				
			end
		end

		context "employee is logged in" do
			before(:each) do
				
			end	

			it "loads the job posting applications that aren't deleted" do
				
			end

			it "loads the job posting applications associated with a jobposting that aren't deleted" do
				
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				
			end
		end
	end

	describe "GET show" do
		context "user is logged in" do
			it "redirects the user to the sign in page" do
				
			end
		end

		
		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				
			end
		end
	end

	describe "GET new" do
		context "user is not an employee" do
			before(:each) do
				
			end	

			it "redirects the user to the current user page" do
				
			end
		end

		context "user is an employee" do
			before(:each) do
				
			end	

			it "renders the forum to create the application" do
				
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				
			end
		end
	end

	describe "POST create" do
		context "user is not an employee" do
			before(:each) do
				
			end	

			it "redirects the user to the current user page" do
				
			end

		end

		context "user is an employee" do
			before(:each) do
				
			end	

			it "creates the application" do
				
			end

			it "creates a notification for the company" do
				
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				
			end
		end
	end

	describe "PATCH update" do
		context "user is not the company of the application" do
			before(:each) do
				
			end	

			it "redirects the user to the current user page" do
				
			end
		end

		context "user is the company of the application" do
			before(:each) do
				
			end	

			it "sets the status of the application" do
				
			end

			it "creates a notification for the applicant" do
				
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				
			end
		end
	end

	describe "DELETE destroy" do
		context "user is not the applicant of the application" do
			before(:each) do
				
			end	

			it "redirects the user to the current user page" do
				
			end
		end

		context "user is the applicant of the application" do
			before(:each) do
				
			end	

			it "sets the status of the applicant to -2" do
				
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				
			end
		end
	end
end