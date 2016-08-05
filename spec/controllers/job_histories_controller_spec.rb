require 'rails_helper'

RSpec.describe JobHistoriesController, type: :controller do

	let(:user) { FactoryGirl.create(:user) }
	let(:user2) { FactoryGirl.create(:user2) }
	let(:job_history) { FactoryGirl.create(:job_history) }
	before do
		user.confirm
		user2.confirm
	end
	
	describe "Get index" do
		
		it "loads the jobs related to current user" do
			sign_in user
			get :index
			expect(assigns(:job_history)).to eq(JobHistory.where(user_id: user.id))
		end
	end

	describe "Get new" do
	
		let(:job_history) { FactoryGirl.create(:job_history) }
		let(:user) { FactoryGirl.create(:user) }

		it "get new page" do
			sign_in user
			get :new
			expect(response).to render_template(:new)
		end

	end






	describe "POST create" do
		let(:job_history) { FactoryGirl.build(:job_history) }
		let(:job_histories_attr) { 
			{ employer: job_history.employer,
			  start_date: job_history.start_date,
			  end_date: job_history.end_date,
			  position: job_history.position,
			  description: job_history.description,
			  skills: job_history.skills,
			  user_id: job_history.user_id
			} 
		}

		context "creates the job history" do
			before(:each) do
				
				sign_in user
				post :create, job_history: job_histories_attr
			end

			it "should have the new jobhistory" do
				expect(JobHistory.last.user_id).to eq(job_history.user_id)
			end


			it "redirects to the root page if sucessful with a message" do
				expect(response).to redirect_to(job_histories_path)
				expect(flash[:success]).to eq("Thank you for adding to your Job History!")
			end
		end
	end
describe "PATCH update" do

		context "user is not logged in" do
			it "redirects the user when not logged in" do
				patch :update, id: job_history.id
		
								
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is logged in" do	

			it "redirects if user is not the job history's owner" do
				sign_in user2
				patch :update, id: job_history.id

				expect(response).to redirect_to(user_path(user2))
				expect(flash[:danger]).to eq("Access denied as you are not owner of this Job History")
			end

			it "updates the job history" do
				sign_in user
				patch :update, id: job_history.id

				expect(response).to redirect_to(job_history_path(job_history))
				expect(flash[:success]).to eq("Thank you for updating to your Job History!")
			end
		end
	end
	describe "DELETE delete" do
		context "incorrect user" do
			it "redirects the user when not logged in" do
				delete :destroy, id: job_history.id
				expect(response).to redirect_to(new_user_session_path)
			end

			it "redirects if user is not the job history's owner" do
				sign_in user2
				delete :destroy, id: job_history.id
				expect(response).to redirect_to(user_path(user2))
				expect(flash[:danger]).to eq("Access denied as you are not owner of this Job History")
			end
		end
		context "user is logged in" do
			before(:each) do
				sign_in user
				delete :destroy, id: job_history.id
			end	
			it "redirects to job history page after deleting" do
				expect(response).to redirect_to(job_histories_path)
				expect(flash[:success]).to eq("Successfully Deleted.")
			end
			it "should not have the job history" do
				expect(JobHistory.where(id: job_history.id).first).to be_nil
			end


		end

	end


	
end

