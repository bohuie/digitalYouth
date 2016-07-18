require 'rails_helper'

RSpec.describe JobHistoriesController, type: :controller do

	let(:user) { FactoryGirl.create(:user) }
	let(:job_history) { FactoryGirl.create(:job_history) }
	before do
			user.confirm
	end
	
	describe "Get index" do

		before do
			get :index
		end
		
		it "loads the jobs related to current user" do
			expect(assigns(:job_history)).to eq(:job_history.where(owner_id: user.id, owner_type: "User"))
		end
	end

	describe "Get new" do
	
		let(:job_history) { FactoryGirl.create(:job_history) }
		let(:user) { FactoryGirl.create(:user) }

		it "redirects to job histories index page if successful with equivilent flash msg" do

			expect(response).to redirect_to(job_histories_path)
			expect(flash[:success]).to eq("Thank you for adding to your Job History!")
		end

		it "redirects to job histories index page if unsuccessful with equivilent flash msg" do

			expect(response).to redirect_to(job_histories_path)
			expect(flash[:danger]).to eq("There was a problem in saving your Job History!")
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

				post :create, id: job_history.id, jobhistories: job_histories_attr
			end

			it "should have the new jobhistory" do
				expect(job_history.last.userid).to eq(job_history.userid)
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
		
				expect(response).to redirect_back_or job_histories_path
				expect(flash[:danger]).to eq("There was a problem in updating your Job History!")
			end
		end

		context "user is logged in" do	

			it "redirects if user is not the job history's owner" do
				sign_in user
				patch :update, id: job_history.id

				expect(response).to redirect_back_or job_histories_path
				expect(flash[:danger]).to eq("There was a problem in updating your Job History!")
			end

			it "updates the job history" do
				sign_in user
				patch :update, id: job_history.id

				expect(response).to redirect_back_or job_histories_path
				expect(flash[:success]).to eq("Thank you for updating to your Job History!")
			end
		end
	end
	describe "DELETE delete" do
		context "incorrect user" do
			it "redirects the user when not logged in" do
				delete :delete, id: job_history.id
				expect(response).to redirect_to(job_histories_path)
			end

			it "redirects if user is not the job history's owner" do
				sign_in user
				delete :delete, id: job_history.id
				expect(response).to redirect_to(redirect_to current_user)
				expect(flash[:notice]).to eq("Access denied as you are not owner of this Job History")
			end
		end
		context "user is logged in" do
			before(:each) do
				sign_in user
				delete :delete, id: job_history.id
			end	
			it "redirects to job history page after deleting" do
				expect(response).to redirect_to(job_histories_path)
				expect(flash[:success]).to eq("Successfully Deleted.")
			end
			it "should not have the job history" do
				expect {JobHistory.find(job_history.id)}.to raise_exception(ActiveRecord::RecordNotFound)
			end


		end

	end


	
end

