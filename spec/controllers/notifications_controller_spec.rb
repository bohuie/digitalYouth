require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do

	describe "GET index" do
		let(:user) { FactoryGirl.create(:user) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}
		
		context "user is logged in" do
			before(:each) do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				get :index
			end	

			it "loads the users notifications" do
				expect(assigns(:activities)).to match_array(PublicActivity::Activity.order("created_at desc").where(owner_id: user.id, owner_type: "User"))
			end

			it "marks all the notifications as seen" do
				expect(PublicActivity::Activity.where(owner_id: user.id, owner_type: "User", is_seen: false).count).to eq(0)
			end
		end

		context "user is not logged in" do
			it "redirects the user to  the login page" do
				get :index
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "GET show" do
		let(:user) { FactoryGirl.create(:user) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		
		context "user is logged in" do
			before(:each) do
				sign_in user
				user.references << reference1
				xhr :get, :show
			end	

			it "loads the users first 5 notifications" do
				expect(assigns(:dropdown_activities)).to match_array(PublicActivity::Activity.order("created_at desc").where(owner_id: user.id, owner_type: "User").limit(5))
			end

			it "marks all the notifications as seen" do
				expect(PublicActivity::Activity.where(owner_id: user.id, owner_type: "User", is_seen: false).count).to eq(0)
			end
		end

		context "user is not logged in" do
			it "redirects the user, effectively blocking the request" do
				xhr :get, :show
				expect(response.status).to eq(401) 
			end
		end
	end

	describe "PATCH update" do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}

		context "correct user is logged in" do # THESE FAIL FOR SOME REASON
			before(:each) do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				
				xhr :patch, :update, id: notification.id
			end	

			it "marks the notification as read" do
				expect(PublicActivity::Activity.find(notification.id).is_read).to eq(true)
			end

			it "reloads the users first 5 notifications" do
				expect(assigns(:dropdown_activities)).to match_array(PublicActivity::Activity.order("created_at desc").where(owner_id: user.id, owner_type: "User").limit(5))
			end
		end

		context "incorrect user is logged in" do
			before(:each) do
				sign_in user2
				user.references << reference1
				notification.owner = user
				notification.save
				xhr :patch, :update, id: notification.id
			end

			it "redirects the user" do
				expect(response.status).to eq(302) 
			end
		end

		context "user is not logged in" do
			it "redirects to the signin page" do
				xhr :patch, :update, id: notification.id
				expect(response.status).to eq(401) 
			end
		end
	end

	describe "DELETE delete" do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}

		context "correct user is logged in" do # THESE FAIL FOR SOME REASON
			before(:each) do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				@count = PublicActivity::Activity.count
				xhr :delete, :delete, id: notification.id
			end	

			it "should have one less reference" do
				expect(PublicActivity::Activity.count).to eq(@count-1)
			end

			it "should not have the reference" do
				expect {PublicActivity::Activity.find(notification.id)}.to raise_exception(ActiveRecord::RecordNotFound)
			end

			it "reloads the users first 5 notifications" do
				expect(assigns(:dropdown_activities)).to match_array(PublicActivity::Activity.order("created_at desc").where(owner_id: user.id, owner_type: "User").limit(5))
			end
		end

		context "incorrect user is logged in" do
			before(:each) do
				sign_in user2
				user.references << reference1
				notification.owner = user
				notification.save
				xhr :patch, :update, id: notification.id
			end

			it "redirects the user" do
				expect(response.status).to eq(302) 
			end
		end

		context "user is not logged in" do
			it "redirects to the signin page" do
				xhr :patch, :update, id: notification.id
				expect(response.status).to eq(401) 
			end
		end
	end

	describe "GET trackable" do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}

		context "user is logged in" do
			before(:each) do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				xhr :get, :trackable, id: notification.id
			end	

			it "marks the notification as read" do
				expect(PublicActivity::Activity.find(notification.id).is_read).to eq(true)
			end

			it "redirects to the notification object path" do
				expect(response).to redirect_to(reference_path(notification.trackable))
			end
		end

		context "incorrect user is logged in" do
			before(:each) do
				sign_in user2
				user.references << reference1
				notification.owner = user
				notification.save
				xhr :patch, :update, id: notification.id
			end

			it "redirects the user" do
				expect(response.status).to eq(302) 
			end
		end

		context "user is not logged in" do
			it "redirects the user, effectively blocking the request" do
				xhr :get, :show
				expect(response.status).to eq(401) 
			end
		end
	end

	describe "notifications bar methods" do
		let(:user) { FactoryGirl.create(:user) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}
		
		context "user is logged in with few notifications" do
			before(:each) do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				@count = PublicActivity::Activity.where(is_seen: false, owner_id: user.id, owner_type: "User").count

				# The notification bar is setup before the get :index so the tests pass
				get :index 
			end	

			it "records the count of unseen notifications" do
				expect(assigns(:notif_unseen)).to eq(@count)
			end

			it "formats the string for the 'show all notifications' link" do
				expect(assigns(:show_all_string)).to eq("Show all notifications")
			end
		end

		#TODO
		context "user is logged in with many notifications" do
			before(:each) do
			end	

			it "formats the string for the 'show all notifications' link" do
				#expect(assigns(:show_all_string)).to eq("Show all notifications - # more unseen")
				#Should test with many notifications too
			end
		end

		context "user is not logged in" do
			it "doesn't display anything" do
				expect(assigns(:notif_unseen)).to be_nil
				expect(assigns(:show_all_string)).to be_nil
			end
		end
	end
end
