require 'rails_helper'

RSpec.describe ReferencesController, type: :controller do 

	describe "GET index" do
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:reference2) { FactoryGirl.create(:reference2) }
		let(:user) { FactoryGirl.create(:user) }
		before do
			user.references << reference1
			user.references << reference2
			user.confirm
		end

		context "user is logged in" do
			before(:each) do
				sign_in user	
				get :index
			end	

			it "loads the users unconfirmed references" do
				expect(assigns(:unconfirmed_references)).to match_array(reference1)
			end

			it "loads the users confirmed references" do
				expect(assigns(:confirmed_references)).to match_array(reference2)
			end

			it "loads the users reference requests" do
				expect(assigns(:reference_requests)).to match_array(ReferenceRedirection.where(email: user.email))
			end
		end

		context "user is not logged in" do
			it "redirects the user when not logged in" do
				get :index
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "GET email" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			user.confirm
		end

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
		before do
			user.confirm
			sign_in user
		end

		it "sends an email to the reference" do
			post :send_mail, reference_email: reference_email
			expect(ActionMailer::Base.deliveries.count).to eq(1)
		end

		it "redirects back if the there are missing fields" do
			post :send_mail
			expect(response).to redirect_to(email_reference_path)
		end
	end

	describe "GET new" do
		let(:reference_redirection1) { FactoryGirl.create(:reference_redirection1) }
		let(:user) { FactoryGirl.create(:user) }
		before do
			user.reference_redirections << reference_redirection1
			user.confirm
		end

		it "redirects to root if the phrase is not in the db" do
			get :new, id:"phrase"
			expect(response).to redirect_to(root_path)
		end

		it "loads the page if the phrase is in the db" do
			get :new, id: reference_redirection1.reference_url
			expect(response).to render_template(:new)
		end
	end

	describe "POST create" do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:reference_redirection1) { FactoryGirl.create(:reference_redirection1) }
		let(:reference_redirection2) { FactoryGirl.create(:reference_redirection2) }
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

		before do
			user2.reference_redirections << reference_redirection1
			user.confirm
		end

		context "is missing required fields" do
			it "redirects back to the new page" do
				@request.env['HTTP_REFERER'] = "http://test.host/references/new/"+reference_redirection1.reference_url
				reference_attr[:company] = ""
				post :create, reference: reference_attr
				expect(response).to redirect_to(request.env["HTTP_REFERER"])
			end
		end

		context "wasn't posted to by the right page" do
			it "redirects back" do
				post :create, reference: reference_attr
				expect(response).to redirect_to(root_path)
			end
		end

		context "referee is signed in is the person being referenced" do
			it "redirects" do
				user.reference_redirections << reference_redirection2
				sign_in user
				@request.env['HTTP_REFERER'] = "http://test.host/references/new/"+reference_redirection2.reference_url
				post :create, reference: reference_attr
				expect(response).to redirect_to(request.env["HTTP_REFERER"])
			end
		end

		context "referee is signed in and has all required fields filled in" do
			it "the reference should have the referee reference" do
				sign_in user
				@request.env['HTTP_REFERER'] = "http://test.host/references/new/"+reference_redirection2.reference_url
				post :create, reference: reference_attr
				expect(Reference.last.referee_id).to eq(user.id)
			end
		end

		context "referee is not signed in and has all required fields filled in" do
			before(:each) do
				@count = Reference.count
				@request.env['HTTP_REFERER'] = "http://test.host/references/new/"+reference_redirection1.reference_url
				post :create, reference: reference_attr
			end

			it "increases the count by one" do
				expect(Reference.count).to eq(@count+1)
			end

			it "should have the new reference in it" do
				expect(Reference.last.first_name).to eq(reference1.first_name)
			end

			it "should create a new notification" do
				reference1 = Reference.last
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

		before do
			user.confirm
			user2.confirm
		end

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

	describe "DELETE destroy" do
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }

		before do
			user.confirm
			user2.confirm
		end

		context "incorrect user" do
			it "redirects the user when not logged in" do
				delete :destroy, id: reference1.id
				expect(response).to redirect_to(new_user_session_path)
			end

			it "redirects if user is not the reference's owner" do
				sign_in user2
				delete :destroy, id: reference1.id
				expect(response).to redirect_to(user_path(user2))
			end
		end

		context "user is logged in" do
			before(:each) do
				sign_in user
				user.references << reference1
				@count = Reference.count
				delete :destroy, id: reference1.id
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