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

			it "loads the users paginated notifications" do
				expect(assigns(:activities)).to match_array(PublicActivity::Activity.order("created_at desc").where(owner_id: user.id, owner_type: "User").limit(20))
			end

			it "marks all the notifications as seen" do
				expect(PublicActivity::Activity.where(owner_id: user.id, owner_type: "User", is_seen: false).count).to eq(0)
			end
		end

		context "user is not logged in" do
			it "redirects the user to the login page" do
				get :index

				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "GET show" do
		let(:user) { FactoryGirl.create(:user) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		
		context "user is logged in and clicks on the notifications icon" do
			before(:each) do
				sign_in user
				user.references << reference1
				xhr :get, :show
			end	

			it "loads the users first 6 notifications" do
				expect(assigns(:dropdown_activities)).to match_array(PublicActivity::Activity.order("created_at desc").where(owner_id: user.id, owner_type: "User").limit(6))
			end

			it "marks all the notifications as seen" do
				expect(PublicActivity::Activity.where(owner_id: user.id, owner_type: "User", is_seen: false).count).to eq(0)
			end
		end

		context "user is logged in and loads more notifications" do
			it "loads the users next notification" do
				sign_in user
				user.references << reference1
				xhr :get, :show, page: 2
			
				expect(assigns(:dropdown_activities)).to match_array(
					PublicActivity::Activity.order("created_at desc").where(owner_id: user.id, owner_type: "User").offset(6).limit(1))
			end
		end

		context "user is not logged in" do
			it "redirects the user to the login page" do
				xhr :get, :show

				pending "TODO: Redirect/route to new_user_session_path"
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "PATCH update" do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}

		context "correct user is logged in" do # THESE FAIL FOR SOME REASON
			it "marks the notification as read" do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				
				xhr :patch, :update, id: notification.id
			
				expect(PublicActivity::Activity.find(notification.id).is_read).to eq(true)
			end
		end

		context "incorrect user is logged in" do
			it "redirects to user page" do
				sign_in user2
				user.references << reference1
				notification.owner = user
				notification.save
				xhr :patch, :update, id: notification.id
	
				expect(response).to redirect_to(user_path(user2))
			end
		end

		context "user is not logged in" do
			it "redirects the user to the login page" do
				xhr :patch, :update, id: notification.id

				pending "TODO: Redirect/route to new_user_session_path"
				expect(response).to redirect_to(new_user_session_path)
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

			it "should have one less notification" do
				expect(PublicActivity::Activity.count).to eq(@count-1)
			end

			it "should not have the notification" do
				expect {PublicActivity::Activity.find(notification.id)}.to raise_exception(ActiveRecord::RecordNotFound)
			end
		end

		context "incorrect user is logged in" do
			it "redirects to user page" do
				sign_in user2
				user.references << reference1
				notification.owner = user
				notification.save
				xhr :delete, :delete, id: notification.id
			
				expect(response).to redirect_to(user_path(user2))
			end
		end

		context "user is not logged in" do
			it "redirects the user to the login page" do
				xhr :delete, :delete, id: notification.id

				pending "TODO: Redirect/route to new_user_session_path"
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "PATCH update_all" do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}

		context "correct user is logged in" do # THESE FAIL FOR SOME REASON
			it "marks all notifications as read" do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				
				xhr :patch, :update_all
			
				expect(PublicActivity::Activity.where(owner_id: user.id, owner_type: "User", is_read: false).count).to eq(0)
			end
		end

		context "user is not logged in" do
			it "redirects the user to the login page" do
				xhr :patch, :update_all

				pending "TODO: Redirect/route to new_user_session_path"
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "DELETE delete_all" do
		let(:user) { FactoryGirl.create(:user) }
		let(:user2) { FactoryGirl.create(:user2) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}

		context "correct user is logged in" do # THESE FAIL FOR SOME REASON
			it "should have no notifications left" do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				
				xhr :delete, :delete_all

				expect(PublicActivity::Activity.where(owner_id: user.id, owner_type: "User", is_read: false).count).to eq(0)
			end
		end

		context "user is not logged in" do
			it "redirects the user to the login page" do
				xhr :delete, :delete, id: notification.id

				pending "TODO: Redirect/route to new_user_session_path"
				expect(response).to redirect_to(new_user_session_path)
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
			it "redirects to user page" do
				sign_in user2
				user.references << reference1
				notification.owner = user
				notification.save
				xhr :get, :trackable, id: notification.id

				expect(response).to redirect_to(user_path(user2))
			end
		end

		context "user is not logged in" do
			it "redirects the user, effectively blocking the request" do
				xhr :get, :trackable, id: notification.id

				pending "TODO: Redirect/route to new_user_session_path"
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "notifications bar methods" do
		let(:user) { FactoryGirl.create(:user) }
		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:notification) {PublicActivity::Activity.find_by(trackable: reference1)}
		
		context "user is logged in with a few notifications" do
			before(:each) do
				sign_in user
				user.references << reference1
				notification.owner = user
				notification.save
				@count = PublicActivity::Activity.where(is_seen: false, owner_id: user.id, owner_type: "User").count

				get :index # The notification bar is setup before the get :index so the tests pass
			end	

			it "records the count of unseen notifications" do
				expect(assigns(:notif_unseen)).to eq(@count)
			end

			it "it doesn't change the font size" do
				expect(assigns(:notif_count_style)).to eq("")
			end
		end
		
		context "user is not logged in" do
			it "doesn't display anything" do
				expect(assigns(:notif_unseen)).to be_nil
			end
		end
	end
end
