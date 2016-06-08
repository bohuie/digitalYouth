require 'rails_helper'

RSpec.describe ReferencesController, type: :controller do 

	describe "GET index" do

		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:reference2) { FactoryGirl.create(:reference2) }
		let(:user) { FactoryGirl.create(:user) }

		context "user is logged in" do
			before(:each) do
				sign_in user
				user.references << reference1
				user.references << reference2
				get :index
			end	

			it "loads the users unconfirmed references" do
				expect(assigns(:unconfirmed_references)).to match_array(reference1)
			end

			it "loads the users confirmed references" do
				expect(assigns(:confirmed_references)).to match_array(reference2)
			end
		end

		context "user is not logged in" do
			it "redirects the user when not logged in" do
				get :index

				expect(response).to redirect_to(new_user_session_path)
			end
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

	describe "POST send_mail" do
		let(:reference1) { FactoryGirl.create(:reference_email1) }
		let(:reference_email) { { first_name: reference1.first_name, last_name: reference1.last_name, email: reference1.email, reference_url: reference1.reference_url} }
		let(:user) { FactoryGirl.create(:user) }


		it "sends an email to the reference" do
			sign_in user
			post :send_mail, reference_email: reference_email

			expect(ActionMailer::Base.deliveries.count).to eq(1)
		end
	end

	describe "POST create" do
		let(:reference_redirection1) { FactoryGirl.create(:reference_redirection1) }
		let(:reference1) { FactoryGirl.build(:reference1) }
		let(:reference_attr) { 
			{ first_name: reference1.first_name,
			  last_name: reference1.last_name,
			  company: reference1.company,
			  position: reference1.position,
			  email: reference1.email,
			  phone_number: reference1.phone_number,
			  reference_body: reference1.reference_body,
			  user_id: reference_redirection1.user_id
			} 
		}

		context "creates the reference" do
			before(:each) do
				@count = Reference.count
				@request.env['HTTP_REFERER'] = "http://localhost/references/new/chDXcg5FJFdG_w"

				post :create, id: reference1.id, reference: reference_attr
			end

			it "increases the count by one" do
				expect(Reference.count).to eq(@count+1)
			end

			it "should have the new reference in it" do
				expect(Reference.last.first_name).to eq(reference1.first_name) #should make this more comprehensive
			end

			it "should create a new notification" do
				expect(PublicActivity::Activity.last.trackable).to eq(reference1)
			end

			it "redirects to the root page if sucessful with a confirmation msg" do
				expect(response).to redirect_to(root_path)
				expect(flash[:success]).to eq("Thank you for making a reference!")
			end
		end
	end

	describe "PATCH update" do
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }

		context "user is not logged in" do
			it "redirects the user when not logged in" do
				patch :update, id: reference1.id
		
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "user is logged in" do
			before(:each) do
				user.references << reference1
			end	

			it "redirects if user is not the reference's owner" do
				sign_in user2
				patch :update, id: reference1.id

				expect(response).to redirect_to(user_path(user2))
			end

			it "updates the reference to set confirmed to the opposite" do
				sign_in user
				patch :update, id: reference1.id

				expect(Reference.find(reference1.id).confirmed).to eq(true)
			end
		end
	end

	describe "DELETE delete" do
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }

		context "incorrect user" do
			it "redirects the user when not logged in" do
				delete :delete, id: reference1.id
				expect(response).to redirect_to(new_user_session_path)
			end

			it "redirects if user is not the reference's owner" do
				sign_in user2
				delete :delete, id: reference1.id
				expect(response).to redirect_to(user_path(user2))
			end
		end

		context "user is logged in" do
			before(:each) do
				sign_in user
				user.references << reference1
				@count = Reference.count
				delete :delete, id: reference1.id
			end	

			it "redirects to references page after deleting" do
				expect(response).to redirect_to(references_path)
			end

			it "should have one less reference" do
				expect(Reference.count).to eq(@count-1)
			end

			it "should not have the reference" do
				expect {Reference.find(reference1.id)}.to raise_exception(ActiveRecord::RecordNotFound)
			end
		end
	end

end