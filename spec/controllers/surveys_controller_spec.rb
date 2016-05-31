require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
	
	describe "GET show" do
		let(:survey1) { Survey.find_by(title: "General") }
		let(:response1) {FactoryGirl.create(:response1)}
		let(:user) { FactoryGirl.create(:user) }

		it "redirects when not logged in" do
			get :show, title: survey1.title

			expect(response).to redirect_to(new_user_session_path)
		end

		context "user is logged in" do
			before(:each) do
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
