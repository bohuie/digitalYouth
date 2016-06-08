require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

	describe "GET index" do

		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:user) { FactoryGirl.create(:user) }

		context "user is logged in" do
			before(:each) do
				sign_in user
				user.references << reference1
				get :index
			end	

			it "loads the users notifications" do
				
			end
		end

		context "user is not logged in" do
			it "redirects the user when not logged in" do
				get :index

				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end
end
