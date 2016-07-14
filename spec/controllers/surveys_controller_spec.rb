require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
	#If these fail, reseed or seed test DB
	describe "GET show" do
		let(:survey1) { Survey.find_by(title: "General") }
		let(:response1) {FactoryGirl.create(:response1)}
		let(:user) { FactoryGirl.create(:user) }
		before do
			user.confirm
		end

		it "redirects when not logged in" do
			byebug
			get :show, title: survey1.title
			expect(response).to redirect_to(new_user_session_path)
		end

		it "redirects if the user is not an employee" do
			sign_in user
			get :show, title: survey1.title
			expect(response).to redirect_to(user_path(user))
		end

		context "employee user is logged in" do
			before(:each) do
				user.add_role(:employee)
				sign_in user
			end

			it "loads the survey when signed in" do	
				get :show, title: survey1.title

				expect(assigns(:survey)).to eq(survey1)
			end

			it "loads the survey data when a survey is to be updated" do
				user.responses << response1
				get :show, title: survey1.title

				expect(assigns(:values_array)).to eq(response1.scores)
			end
		end
	end
end
