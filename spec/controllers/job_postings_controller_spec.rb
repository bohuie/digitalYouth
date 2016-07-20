require 'rails_helper'

RSpec.describe JobPostingsController, type: :controller do 

	describe "GET index" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				user.confirm
			end
		
		context "employer is logged in" do
			before(:each) do
				
				get :index
			end	

			it "loads the users job posting" do
				expect(assigns(:job_postings)).to match_array(JobPosting.where(user_id: user))
			end

			it "loads another users job postings if params[:user] is present" do
				expect(assigns(:job_postings)).to match_array(JobPosting.where(user_id: user2))
			end
		end

		context "an employer is not logged in" do
			before(:each) do
				
				get :index
			end

			it "loads another users job postings if params[:user] is present" do
				expect(assigns(:job_postings)).to match_array(JobPosting.where(user_id: user2))
			end
		end
	end

	describe "GET show" do
		context "current user does not own the jobposting" do
			before(:each) do
				
				get :show
			end

			it "loads the job posting" do
				expect(assigns(:job_posting)).to eq(JobPosting.find(params[:id]))
			end

			it "sets the company name to the associated user company name if it is nil" do
				
			end

			it "loads the required skills" do
				
			end

			it "loads the preferred skills" do
				
			end

			it "increments the view counter" do
				
			end
		end

		context "current user is logged in and owns the jobposting" do
			before(:each) do
				
				get :show
			end

			it "does not increment the view counter" do
				
			end
		end
	end

	describe "GET new" do
		context "user is not logged in" do
			it "redirects the user" do
				get :new
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				get :new
			end
		end

		context "user is logged in and is an employer" do
			it "loads the new page " do
			get :new

			expect(response).to render_template(:new)
			end
		end
	end


	@job_posting = JobPosting.new
		job_posting_skills = @job_posting.job_posting_skills.build
		job_posting_skills.skill = Skill.new
		@questions = Question.get_label_map
		@skills = Skill.all

	describe "POST create" do
		context "user is not logged in" do
			it "redirects the user" do
				post :create
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				post :create
			end
		end

		context "user is logged in and is an employer" do
			before(:each) do
				@count = JobPosting.count
				post :create
			end

			it "increases the count by one" do
				expect(JobPosting.count).to eq(@count+1)
			end

			it "has the new jobposting in it" do
				
			end

			it "creates skills and job_posting_skills" do
				# Actually done in the model
			end

			it "redirects to the jobposting page if sucessful with a confirmation msg" do
				expect(response).to redirect_to(root_path)
				expect(flash[:success]).to eq("")
			end

		end
	end

	describe "GET edit" do
		context "user is not logged in" do
			it "redirects the user" do
				get :edit, id:
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				get :edit, id:
			end
		end

		context "user is logged in does not own the posting" do
			it "redirects the user" do
				get :edit, id:
			end
		end

		context "user is logged in and is an employer" do
			it "loads the edit page " do
			get :edit, id: 

			expect(response).to render_template(:edit)
			end
		end
	end

	describe "PATCH update" do
		context "user is not logged in" do
			it "redirects the user" do
				patch :update, id:
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				patch :update, id:
			end
		end

		context "user is logged in does not own the posting" do
			it "redirects the user" do
				patch :update, id:
			end
		end

		context "user is logged in and is an employer" do
			before(:each) do
				@count = JobPosting.count
				patch :update, id:
			end

			it "sets the category" do
			end

			it "updates the jobposting" do
			end

			it "creates skills and job_posting_skills" do
				# Actually done in the model
			end
		end
	end

	describe "DELETE destroy" do
		context "user is not logged in" do
			it "redirects the user" do
				delete :destroy, id:
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				delete :destroy, id:
			end
		end

		context "user is logged in does not own the posting" do
			it "redirects the user" do
				delete :destroy, id:
			end
		end

		context "user is logged in and is an employer" do
			before(:each) do
				@count = JobPosting.count
				delete :destroy, id:
			end
			
			it "deletes the posting" do

			end

			it "redirects the user" do

			end
		end
	end
end