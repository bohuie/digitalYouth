require 'rails_helper'

RSpec.describe JobPostingApplicationsController, type: :controller do

	describe "GET index" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:user) { FactoryGirl.create(:user) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		let(:job_posting_application) { FactoryGirl.create(:job_posting_application) }

		before do
			user.confirm
			employer.confirm
			user.add_role :employee
			employer.add_role :employer
			employer.job_postings << job_posting
			job_posting_application.applicant = user
			job_posting_application.company = employer
			job_posting_application.job_posting = job_posting
			job_posting_application.save
		end

		context "employee is logged in" do
			before(:each) do
				sign_in user
			end

			it "loads the job posting applications that aren't deleted" do
				get :index
				expect(assigns(:job_posting_applications)).to match_array(JobPostingApplication.where(applicant_id:user.id, status:-1..Float::INFINITY).order(status: :desc))
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				get :index
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "employer is logged in" do
			before(:each) do
				sign_in employer
			end	

			it "loads the job posting applications that aren't deleted" do
				get :index
				expect(assigns(:job_posting_applications)).to match_array(JobPostingApplication.where(company_id:employer.id, status:-1..Float::INFINITY).order(status: :desc))
			end

			it "loads the job posting applications associated with a jobposting that aren't deleted" do
				get :index, job_posting: job_posting.id
				expect(assigns(:job_posting_applications)).to match_array(JobPostingApplication.where(company_id:employer.id, status:-1..Float::INFINITY,job_posting_id:job_posting.id).order(status: :desc))
			end
		end		
	end

	describe "GET show" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		let(:job_posting_application) { FactoryGirl.create(:job_posting_application) }

		before do
			user.confirm
			user2.confirm
			employer.confirm
			user.add_role :employee
			user2.add_role :employee
			employer.add_role :employer
			employer.job_postings << job_posting
			job_posting_application.applicant = user
			job_posting_application.company = employer
			job_posting_application.job_posting = job_posting
			job_posting_application.save
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				get :show, id: job_posting_application.id 
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is not associated with the application" do
			it "redirects the user to the current user page" do
				sign_in user2
				get :show, id: job_posting_application.id 
				expect(response).to redirect_to(user2)
			end
		end

		context "applicant is logged in" do
			it "loads the application" do
				sign_in user
				get :show, id: job_posting_application.id 
				expect(assigns(:job_posting_application)).to eq(JobPostingApplication.find(job_posting_application.id))
			end
		end

		context "company is logged in" do
			it "loads the application" do
				sign_in employer
				get :show, id: job_posting_application.id 
				expect(assigns(:job_posting_application)).to eq(JobPostingApplication.find(job_posting_application.id))
			end
		end
	end

	describe "GET new" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:user) { FactoryGirl.create(:user) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }

		before do
			user.confirm
			employer.confirm
			user.add_role :employee
			employer.add_role :employer
			employer.job_postings << job_posting
		end

		context "user is not an employee" do
			it "redirects the user to the current user page" do
				sign_in employer
				get :new, job_posting: job_posting.id
				expect(response).to redirect_to(employer)
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				get :new, job_posting: job_posting.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is an employee" do
			it "renders the form to create the application" do
				sign_in user
				get :new, job_posting: job_posting.id
				expect(response).to render_template(:new)
			end
		end
	end

	describe "POST create" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:user) { FactoryGirl.create(:user) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		let(:job_posting_application) { FactoryGirl.build(:job_posting_application) }
		let(:job_posting_application_attr) { {
			  message: "This is a good application",
			  job_posting_id: job_posting.id,
			  applicant_id: user.id,
			  company_id: employer.id
			} }

		before do
			user.confirm
			employer.confirm
			user.add_role :employee
			employer.add_role :employer
			employer.job_postings << job_posting
		end

		context "user is not an employee" do
			it "redirects the user to the current user page" do
				sign_in employer
				get :new, job_posting_application: job_posting_application_attr
				expect(response).to redirect_to(employer)
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				post :create, job_posting_application: job_posting_application_attr
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is an employee" do
			before(:each) do
				sign_in user
				@count = JobPostingApplication.count
				post :create, job_posting_application: job_posting_application_attr
			end	

			it "increases the count by one" do
				expect(JobPostingApplication.count).to eq(@count+1)
			end

			it "has the new JobPostingApplication in the db" do
				expect(JobPostingApplication.last.applicant).to eq(user)
				expect(JobPostingApplication.last.company).to eq(employer)
				expect(JobPostingApplication.last.job_posting).to eq(job_posting)
				expect(JobPostingApplication.last.message).to eq("This is a good application")
			end

			it "creates a notification for the company" do
				expect(PublicActivity::Activity.last.trackable.applicant).to eq(user)
				expect(PublicActivity::Activity.last.trackable.company).to eq(employer)
				expect(PublicActivity::Activity.last.trackable.job_posting).to eq(job_posting)
				expect(PublicActivity::Activity.last.owner).to eq(employer)
			end
		end
	end

	describe "PATCH update" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:employer2) { FactoryGirl.create(:employer2) }
		let(:user) { FactoryGirl.create(:user) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		let(:job_posting_application) { FactoryGirl.create(:job_posting_application) }

		before do
			user.confirm
			employer.confirm
			employer2.confirm
			user.add_role :employee
			employer.add_role :employer
			employer2.add_role :employer
			employer.job_postings << job_posting
			job_posting_application.applicant = user
			job_posting_application.company = employer
			job_posting_application.job_posting = job_posting
			job_posting_application.save
		end

		context "user is not the company of the application" do
			it "redirects the user to the current user page" do
				sign_in employer2
				patch :update, id: job_posting_application.id
				expect(response).to redirect_to(employer2)
			end
		end

		context "user is the applicant of the application" do
			it "redirects the user to the current user page" do
				sign_in user
				patch :update, id: job_posting_application.id
				expect(response).to redirect_to(user)
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				patch :update, id: job_posting_application.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is the company of the application" do
			before(:each) do
				sign_in employer
			end	

			it "sets the status of the application to Rejected" do
				patch :update, id: job_posting_application.id, status: "Rejected"
				expect(JobPostingApplication.find(job_posting_application.id).status).to eq(-1)

				expect(PublicActivity::Activity.last.trackable.status).to eq(-1)
				expect(PublicActivity::Activity.last.owner).to eq(user)
			end

			it "sets the status of the application to Considering" do
				patch :update, id: job_posting_application.id, status: "Considering"
				expect(JobPostingApplication.find(job_posting_application.id).status).to eq(1)

				expect(PublicActivity::Activity.last.trackable.status).to eq(1)
				expect(PublicActivity::Activity.last.owner).to eq(user)
			end

			it "sets the status of the application to Accepted" do
				patch :update, id: job_posting_application.id, status: "Accepted"
				expect(JobPostingApplication.find(job_posting_application.id).status).to eq(2)

				expect(PublicActivity::Activity.last.trackable.status).to eq(2)
				expect(PublicActivity::Activity.last.owner).to eq(user)
			end
		end
	end

	describe "DELETE destroy" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		let(:job_posting_application) { FactoryGirl.create(:job_posting_application) }

		before do
			user.confirm
			user2.confirm
			employer.confirm
			user.add_role :employee
			user2.add_role :employee
			employer.add_role :employer
			employer.job_postings << job_posting
			job_posting_application.applicant = user
			job_posting_application.company = employer
			job_posting_application.job_posting = job_posting
			job_posting_application.save
		end

		context "user is not the applicant of the application" do
			it "redirects the user to the current user page" do
				sign_in user2
				delete :destroy, id: job_posting_application.id
				expect(response).to redirect_to(user2)
			end
		end

		context "user is the company of the application" do
			it "redirects the user to the current user page" do
				sign_in employer
				delete :destroy, id: job_posting_application.id
				expect(response).to redirect_to(employer)
			end
		end

		context "user is not logged in" do
			it "redirects the user to the sign in page" do
				delete :destroy, id: job_posting_application.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is the applicant of the application" do
			it "sets the status of the applicant to -2" do
				sign_in user
				delete :destroy, id: job_posting_application.id
				expect(JobPostingApplication.find(job_posting_application.id).status).to eq(-2)
			end
		end		
	end
end