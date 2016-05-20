require 'rails_helper'

RSpec.describe ReferencesController, type: :controller do 

	describe "GET show" do

		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:reference2) { FactoryGirl.create(:reference2) }
		let(:user) { FactoryGirl.create(:user) }

		it "loads the users unconfirmed references" do
			sign_in user
			user.references << reference1

			get :show
			expect(assigns(:unconfirmed_references)).to match_array(reference1)
		end

		it "loads the users confirmed references" do
			sign_in user
			user.references << reference2

			get :show
			expect(assigns(:confirmed_references)).to match_array(reference2)
		end

		it "redirects the user when not logged in" do
			get :show

			expect(response).to redirect_to(new_user_session_path)
		end
	end

	describe "GET new" do

		let(:reference_redirection1) { FactoryGirl.create(:reference_redirection1) }
		let(:user) { FactoryGirl.create(:user) }

		it "redirects to root if the phrase is not in the db" do
			get :new, id:"phrase"

			expect(response).to redirect_to(root_path)
		end

		it "loads the page if the phrase is in the db" do

			user.reference_redirections << reference_redirection1
			get :new, id: reference_redirection1.reference_url

			expect(response).to render_template(:new)
		end
	end


	describe "GET email" do

		let(:user) { FactoryGirl.create(:user) }

		it "redirects the user when not logged in" do
			get :email

			expect(response).to redirect_to(new_user_session_path)
		end

		it "loads the page if the user is logged in" do
			
			sign_in user
			get :email

			expect(response).to render_template(:email)
		end
	end

	#this test is failing
	describe "POST sendMail" do

		let(:reference_email) { FactoryGirl.create(:reference_email1) }
		let(:user) { FactoryGirl.create(:user) }

		it "sends an email to the reference" do
			sign_in user
			post :sendMail
			
			params[:reference_email][:user_id] = user.id

			expect{ReferenceMailer.reference_email(reference_email_params, :user).deliver_now}.to change{ActionMailer::Base.deliveries.count}.by(1)
		end
	end

	describe "POST create" do

		it "creates the reference" do
			
		end

		it "redirects to the root page if sucessful with a confirmation msg" do
			
		end

		it "redirects to the root page if unsucessful with a error msg" do
			
		end
	end

	#I cant figure out why the commented parts error when uncommented
	describe "PATCH update" do
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }

		it "redirects the user when not logged in" do
			patch :update#, :id reference1.id
			byebug
	
			expect(response).to redirect_to(new_user_session_path)
		end

		it "redirects if user is not the reference's owner" do
			user.references << reference1
			sign_in user2

			patch :update#, id: reference1.id

			expect(response).to redirect_to(references_path)
		end

		it "updates the reference to set confirmed to the opposite" do
			patch :update#, :id reference1.id

		end
	end

	#I cant figure out why the commented parts error when uncommented
	describe "DELETE delete" do
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }

		it "redirects the user when not logged in" do
			delete :delete#, :id reference1.id

			expect(response).to redirect_to(new_user_session_path)
		end

		it "redirects if user is not the reference's owner" do
			user.references << reference1
			sign_in user2

			delete :delete#, id: reference1.id

			expect(response).to redirect_to(references_path)
		end

		it "deletes the reference" do
			delete :delete#, :id reference1.id

		end
	end

end