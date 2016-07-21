require 'rails_helper'

RSpec.describe JobPostingsController, type: :controller do 

	describe "GET index" do
			let(:employer) { FactoryGirl.create(:employer) }
			let(:employer2) { FactoryGirl.create(:employer2) }
			let(:job_posting) { FactoryGirl.create(:job_posting) }
			let(:job_posting2) { FactoryGirl.create(:job_posting2) }
			
			before do
				employer.confirm
				employer2.confirm
				employer.add_role :employer
				employer2.add_role :employer
				employer.job_postings << job_posting
				employer2.job_postings << job_posting2
			end
		
		context "employer is logged in" do
			before(:each) do
				sign_in employer
			end	

			it "loads the users job posting" do
				get :index
				expect(assigns(:job_postings)).to match_array(JobPosting.where(user_id: employer))
			end

			it "loads another users job postings if params[:user] is present" do
				get :index, user: employer2.id
				expect(assigns(:job_postings)).to match_array(JobPosting.where(user_id: employer2))
			end
		end

		context "an employer is not logged in" do
			it "loads another users job postings if params[:user] is present" do
				get :index, user: employer.id
				expect(assigns(:job_postings)).to match_array(JobPosting.where(user_id: employer))
			end
		end
	end

	describe "GET show" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		let(:skill){ FactoryGirl.create(:skill) }
		let(:skill2){ FactoryGirl.create(:skill_2) }
		let(:job_posting_skill) { FactoryGirl.create(:job_posting_skill) }
		let(:job_posting_skill2) { FactoryGirl.create(:job_posting_skill2) }
			
		before do
			employer.confirm
			employer.add_role :employer
			employer.job_postings << job_posting
			job_posting_skill.skill = skill 
			job_posting_skill2.skill = skill2
			job_posting_skill.question = Question.first
			job_posting_skill2.question = Question.last
			job_posting.job_posting_skills << job_posting_skill
			job_posting.job_posting_skills << job_posting_skill2
		end

		context "current user does not own the jobposting" do
			before(:each) do
				@view_count = job_posting.views
				get :show, id: job_posting.id
			end

			it "loads the job posting" do
				expect(assigns(:job_posting)).to eq(JobPosting.find(job_posting.id))
			end

			it "sets the company name to the associated user company name if it is nil" do
				expect(assigns(:job_posting).company_name).to eq(employer.company_name)
			end

			it "loads the required skills" do
				expect(assigns(:req_skills)).to match_array(JobPostingSkill.where(job_posting_id: job_posting.id, importance: 2))
			end

			it "loads the preferred skills" do
				expect(assigns(:pref_skills)).to match_array(JobPostingSkill.where(job_posting_id: job_posting.id, importance: 1))
			end

			it "increments the view counter if it is unexpired" do
				expect(assigns(:job_posting).views).to eq(@view_count+1)
			end
		end

		context "current user is logged in and owns the jobposting" do
			before(:each) do
				sign_in employer
				@view_count = job_posting.views
				get :show, id: job_posting.id
			end
			it "does not increment the view counter" do
				expect(assigns(:job_posting).views).to eq(@view_count)
			end
		end
	end

	describe "GET new" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:user) { FactoryGirl.create(:user) }
		before(:each) do
			user.confirm
			employer.confirm
			employer.add_role :employer
		end

		context "user is not logged in" do
			it "redirects the user" do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				sign_in user
				get :new
				expect(response).to redirect_to(user)
			end
		end

		context "user is logged in and is an employer" do
			it "loads the new page " do
				sign_in employer
				get :new
				expect(response).to render_template(:new)
			end
		end
	end

	describe "POST create" do
		let(:employer) { FactoryGirl.create(:employer) }
		let(:user) { FactoryGirl.create(:user) }
		let(:job_posting) { FactoryGirl.build(:job_posting) }
		let(:job_category) { FactoryGirl.create(:job_category) }
		let(:skill) { FactoryGirl.build(:skill) }
		let(:skill2) { FactoryGirl.build(:skill_2) }
		let(:job_posting_attr) { {
			  title: job_posting.title,
			  location: job_posting.location,
			  job_category: job_category.name,
			  pay_range: job_posting.pay_range,
			  link: job_posting.link,
			  posted_by: job_posting.posted_by,
			  description: job_posting.description,
			  open_date: job_posting.open_date,
			  close_date: job_posting.close_date,
			  user_id: employer.id,
			  "job_posting_skills_attributes" => {
			  "0"=>{"id"=>"","skill_attributes"=>{"name"=>skill.name}, "question_id"=>Question.first.id.to_s, "importance"=>"2", "_destroy"=>"false"},
			  "1"=>{"id"=>"","skill_attributes"=>{"name"=>skill2.name}, "question_id"=>Question.last.id.to_s,"importance"=>"1", "_destroy"=>"false"}
			}
		} }

		before(:each) do
			user.confirm
			employer.confirm
			employer.add_role :employer
		end

		context "user is not logged in" do
			it "redirects the user" do
				post :create
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				sign_in user
				get :create
				expect(response).to redirect_to(user)
			end
		end

		context "user is logged in and is an employer and not all required fields are filled" do
			before(:each) do
				sign_in employer
			end
			it "redirects back if required fields are missing" do
				job_posting_attr[:title] = nil
				post :create, job_posting: job_posting_attr
				expect(response).to redirect_to(request.env["HTTP_REFERER"])
			end

			it "redirects back if there are no skills" do
				job_posting_attr["job_posting_skills_attributes"] = {}
				post :create, job_posting: job_posting_attr
				expect(response).to redirect_to(request.env["HTTP_REFERER"])
			end
		end

		context "user is logged in and is an employer and all required fields are filled" do
			before(:each) do
				sign_in employer
				@count = JobPosting.count
				post :create, job_posting: job_posting_attr
			end

			it "increases the count by one" do
				expect(JobPosting.count).to eq(@count+1)
			end

			it "db has the new jobposting in it" do
				expect(JobPosting.last.title).to eq(job_posting.title)
				expect(JobPosting.last.location).to eq(job_posting.location)
				expect(JobPosting.last.description).to eq(job_posting.description)
			end

			it "creates skills and job_posting_skills" do
				expect(Skill.find(JobPostingSkill.where(job_posting_id: JobPosting.last.id).first.skill_id).name.capitalize).to eq(skill.name)
			end

			it "redirects to the jobposting page if sucessful, with a confirmation message" do
				expect(response).to redirect_to(job_postings_path)
				expect(flash[:success]).to eq("Job Posting Created!")
			end
		end
	end

	describe "GET edit" do
		let(:user) { FactoryGirl.create(:user) }
		let(:employer) { FactoryGirl.create(:employer) }
		let(:employer2) { FactoryGirl.create(:employer2) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		before(:each) do
			user.confirm
			employer.confirm
			employer2.confirm
			employer.add_role :employer
			employer2.add_role :employer
			employer.job_postings << job_posting
		end

		context "user is not logged in" do
			it "redirects the user" do
				get :edit, id: job_posting.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				sign_in user
				get :edit, id: job_posting.id
				expect(response).to redirect_to(user)
			end
		end

		context "user is logged in does not own the posting" do
			it "redirects the user" do
				sign_in employer2
				get :edit, id: job_posting.id
				expect(response).to redirect_to(employer2)
			end
		end

		context "user is logged in and is an employer" do
			it "loads the edit page " do
				sign_in employer
				get :edit, id: job_posting.id
				expect(response).to render_template(:edit)
			end
		end
	end

	describe "PATCH update" do
		let(:user) { FactoryGirl.create(:user) }
		let(:employer) { FactoryGirl.create(:employer) }
		let(:employer2) { FactoryGirl.create(:employer2) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
		let(:job_category) { FactoryGirl.create(:job_category) }
		let(:skill){ FactoryGirl.build(:skill) }
		let(:skill2){ FactoryGirl.build(:skill_2) }
		let(:job_posting_skill) { FactoryGirl.create(:job_posting_skill) }
		let(:job_posting_skill2) { FactoryGirl.create(:job_posting_skill2) }
		let(:job_posting_attr) { {
			  title: "New Title",
			  location: job_posting.location,
			  job_category: job_category.name,
			  pay_range: job_posting.pay_range,
			  link: job_posting.link,
			  posted_by: job_posting.posted_by,
			  description: job_posting.description,
			  open_date: job_posting.open_date,
			  close_date: job_posting.close_date,
			  user_id: employer.id,
			  "job_posting_skills_attributes" => {
			  "0"=>{"id"=>"","skill_attributes"=>{"name"=>skill.name}, "question_id"=>Question.first.id.to_s, "importance"=>"2", "_destroy"=>"false"},
			  "1"=>{"id"=>"","skill_attributes"=>{"name"=>skill2.name}, "question_id"=>Question.last.id.to_s,"importance"=>"1", "_destroy"=>"false"}
			}
		} }
			
		before do
			user.confirm
			employer.confirm
			employer2.confirm
			employer.add_role :employer
			employer2.add_role :employer
			employer.job_postings << job_posting
			job_posting_skill.skill = skill 
			job_posting_skill2.skill = skill2
			job_posting_skill.question = Question.first
			job_posting_skill2.question = Question.last
			job_posting.job_posting_skills << job_posting_skill
			job_posting.job_posting_skills << job_posting_skill2
		end

		context "user is not logged in" do
			it "redirects the user" do
				patch :update, id: job_posting.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				sign_in user
				patch :update, id: job_posting.id
				expect(response).to redirect_to(user)
			end
		end

		context "user is logged in does not own the posting" do
			it "redirects the user" do
				sign_in employer2
				patch :update, id: job_posting.id
				expect(response).to redirect_to(employer2)
			end
		end

		context "user is logged in and is an employer and not all required fields are filled" do
			before(:each) do
				sign_in employer
			end

			it "redirects back if required fields are missing" do
				job_posting_attr[:title] = nil
				patch :update, id: job_posting.id, job_posting: job_posting_attr
				pending "Need Rodney to look at why this is failing, redirects to the wrong path with the right actions"
				expect(response).to redirect_to(request.env["HTTP_REFERER"])
			end

			it "redirects back if there are no skills" do
				job_posting_attr["job_posting_skills_attributes"] = {}
				patch :update, id: job_posting.id, job_posting: job_posting_attr
				pending "Need Rodney to look at why this is failing, redirects to the wrong path with the right actions"
				expect(response).to redirect_to(request.env["HTTP_REFERER"])
			end
		end

		context "user is logged in and is an employer and all required fields are filled" do
			before(:each) do
				sign_in employer
				patch :update, id: job_posting.id, job_posting: job_posting_attr
			end

			it "updates the jobposting" do
				expect(JobPosting.find(job_posting.id).title).to eq("New Title")
			end

			it "creates skills and job_posting_skills" do
				expect(Skill.find(JobPostingSkill.where(job_posting_id: JobPosting.last.id).first.skill_id).name.capitalize).to eq(skill.name)
			end

			it "redirects to the jobposting page if sucessful, with a confirmation message" do
				expect(response).to redirect_to(job_postings_path)
				expect(flash[:success]).to eq("Job Posting Updated!")
			end
		end
	end

	describe "DELETE destroy" do
		let(:user) { FactoryGirl.create(:user) }
		let(:employer) { FactoryGirl.create(:employer) }
		let(:employer2) { FactoryGirl.create(:employer2) }
		let(:job_posting) { FactoryGirl.create(:job_posting) }
			
		before do
			user.confirm
			employer.confirm
			employer2.confirm
			employer.add_role :employer
			employer2.add_role :employer
			employer.job_postings << job_posting
		end


		context "user is not logged in" do
			it "redirects the user" do
				delete :destroy, id: job_posting.id
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is logged in and is not an employer" do
			it "redirects the user" do
				sign_in user
				delete :destroy, id: job_posting.id
				expect(response).to redirect_to(user)
			end
		end

		context "user is logged in does not own the posting" do
			it "redirects the user" do
				sign_in employer2
				delete :destroy, id: job_posting.id
				expect(response).to redirect_to(employer2)
			end
		end

		context "user is logged in and is an employer" do
			before(:each) do
				sign_in employer
				@count = JobPosting.count
				delete :destroy, id: job_posting.id
			end

			it "decreases the posting count" do
				expect(JobPosting.count).to eq(@count-1)
			end
			
			it "deletes the posting" do
				expect(JobPosting.where(id:job_posting.id).first).to be_nil
			end

			it "redirects to the jobposting page if sucessful, with a confirmation message" do
				expect(response).to redirect_to(job_postings_path)
				expect(flash[:success]).to eq("Job Posting Deleted!")
			end
		end
 	end
end