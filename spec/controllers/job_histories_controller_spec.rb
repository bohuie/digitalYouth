require 'rails_helper'

RSpec.describe JobHistoriesController, type: :controller do

	let(:user) { FactoryGirl.create(:user) }
	let(:jobhistory) { FactoryGirl.create(:jobhistory, user: user) }

#Having Same Errors as the other tests	
	describe "Get index" do

		before do
			get :index
		end
		
		it "loads the jobs related to current user" do
			expect(assigns(:jobhistory)).to eq(user)
		end
	end

	describe "Get new" do
	
		let(:jobhistory) { FactoryGirl.create(:jobhistory) }
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
		let(:jobhistory_redirection1) { FactoryGirl.create(:jobhistory_redirection1) }
		let(:jobhistory) { FactoryGirl.build(:jobhistory) }
		let(:job_histories_attr) { 
			{ employer: jobhistory.first_name,
			  start_date: jobhistory.last_name,
			  end_date: jobhistory.company,
			  position: jobhistory.position,
			  description: jobhistory.email,
			  skills: jobhistory.phone_number,
			  user_id: jobhistory_redirection1.user_id
			} 
		}

		context "creates the job history" do
			before(:each) do

				post :create, id: jobhistory.id, jobhistories: job_histories_attr
			end

			it "should have the new jobhistory" do
				expect(jobhistory.last.first_name).to eq(jobhistory.first_name)
			end


			it "redirects to the root page if sucessful with a message" do
				expect(response).to redirect_to(job_histories_path)
				expect(flash[:success]).to eq("Thank you for adding to your Job History!")
			end
		end
	end
end

