require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do 

	describe "GET show" do

		context "it finds the project" do
			let(:project1) { FactoryGirl.create(:project) }

			before(:each) do
				get :show, id: project1.id
			end

			it "loads the specified post" do
				expect(assigns(:project)).to eq(project1)
			end
		end

		context "the project doesn't exist" do

			before(:each) do
				get :show, id: 1
			end

			it "should redirect to home" do
				expect(response).to redirect_to root_url	#to implement
			end
		end
	end

	describe "GET new" do

		let(:user) { FactoryGirl.create(:user) }
		let(:project1) { FactoryGirl.create(:project) }

		context "user is not logged in" do
			before (:each) do
				get :new
			end

			it "redirects to login page" do
				expect(response).to redirect_to(new_user_session_path)
			end
			it "has a flash set to log in message" do
				expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
			end
		end

		context "user is logged in" do
			before(:each) do
				user.projects << project1
				sign_in user

				get :new
			end
			it "loads the page" do
				expect(response).to render_template(:new)
			end
		end
	end

	describe "GET edit" do

		let(:user) { FactoryGirl.create(:user) }
		let(:project1) { FactoryGirl.create(:project) }

		context "user is not logged in" do
			before(:each) do
				get :edit, id: project1.id
			end
			it "redirects" do
				expect(response).to redirect_to(new_user_session_path)
			end
			it "has a flash set to log in message" do
				expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
			end
		end

		context "project owner is logged in" do
			
			it "loads the page" do
				user.projects << project1
				sign_in user
				get :edit, id: project1.id

				expect(response).to render_template(:edit)
			end
		end

		context "other user is logged in" do
			let(:other_user) { FactoryGirl.create(:user2) }

			before (:each) do
				user.projects << project1
				sign_in other_user

				get :edit, id: project1.id
			end

			it "redirects to other_user's page" do
				expect(response).to redirect_to(user_path(other_user))
			end

			it "displays a flash warning" do
				expect(flash[:warning]).to eq("You can only make changes to your projects.")
			end
		end
	end

	describe "POST create" do

		let(:project1) { FactoryGirl.build(:project) }
		let(:user) { FactoryGirl.create(:user) }
		let(:project_attr) { { title: project1.title, description: project1.description } }

		context "user not logged in" do
			before (:each) do
				post :create
			end

			it "redirects" do
				expect(response).to redirect_to(new_user_session_path)
			end
			it "has a flash set to log in message" do
				expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
			end
		end

		context "project owner is logged in" do

			before(:each) do
				sign_in user
				post :create, id: project1.id, project: project_attr
			end

			it "should load the page" do
				expect(response).to redirect_to(user_path(user))
			end
		end

		context "project owner creates the project with all fields" do

			before(:each) do
				user.projects << project1
		 		sign_in user
				@count = Project.count

				post :create, id: project1.id, project: project_attr
			end	

			it "increases the count by one" do
				expect(Project.count).to eq(@count+1)
			end

			it "should have the new project in it" do
				expect(Project.last.title).to eq(project1.title)
			end

			it "redirects to profile page" do
				expect(response).to redirect_to(user_path(user))
			end

			it "sets the flash to success" do
				expect(flash[:success]).to eq("Project successfully created.")
			end
		end

		context "project owner is unsuccessful at creating the project" do

			before (:each) do
				user.projects << project1
				sign_in user
				project_attr[:title] = nil
				project_attr[:description] = "new description"
				@count = Project.count

				post :create, id: project1.id, project: project_attr
			end

			it "should render the edit page" do
				should render_template 'users/show'
			end

			it "should set a danger flash message" do
				expect(flash[:danger]).to eq("Please fix the errors below.")	#not sure what is going on
			end

			it "should not increase count" do
				expect(Project.count).to eq(@count)
			end

			it "should not have the new description" do
				expect(Project.find(project1.id).description).not_to eq("new description")
			end
		end
	end

	describe "PATCH update" do

		let(:project1) { FactoryGirl.create(:project) }
		let(:user) { FactoryGirl.create(:user) }
		let(:new_title) { "Hello!" }
		let(:project_attr) { {title: new_title, description: project1.description } }

		context "user is not logged in" do
			before(:each) do
				patch :update, id: project1.id
			end
			it "redirects" do
				expect(response).to redirect_to(new_user_session_path)
			end
			it "has a flash set to log in message" do
				expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
			end
		end

		context "project owner is logged in and successfully updates the project" do

			before (:each) do
				user.projects << project1
				sign_in user
				project_attr[:delete_image] = "1"

				patch :update, id: project1.id, project: project_attr
			end

			it "should load the page" do
				expect(response).to redirect_to(user_path(user))
			end

			it "should have the new information" do
				expect(Project.last.title).to eq(new_title)
			end

			it "should delete the image" do
				expect(Project.last.image_file_name).to be_nil
			end

			it "sets the flash to success" do
				expect(flash[:success]).to eq("Project successfully updated.")
			end
		end

		context "logged in user is unsuccessful at updating the project" do

			before (:each) do
				user.projects << project1
				sign_in user
				project_attr[:title] = nil

				patch :update, id: project1.id, project: project_attr
			end

			it "should render the edit page" do
				should render_template :edit
			end

			it "should set a danger flash message" do
				expect(flash[:danger]).to eq("Please fix the errors below.")
			end
		end

		context "other user is logged in" do
			let(:other_user) { FactoryGirl.create(:user2) }

			before (:each) do
				user.projects << project1
				sign_in other_user

				patch :update, id: project1.id, project: project_attr
			end

			it "redirects to other_user's page" do
				expect(response).to redirect_to(user_path(other_user))
			end

			it "displays a flash warning" do
				expect(flash[:warning]).to eq("You can only make changes to your projects.")
			end
		end
	end

	describe "DELETE delete" do

		let(:project1) { FactoryGirl.create(:project) }
		let(:user) { FactoryGirl.create(:user) }
		let(:project_attr) { { title: project1.title, description: project1.description, image: nil } }

		context "user is not logged in" do
			before(:each) do
				delete :destroy, id: project1.id
			end
			it "redirects when not logged in" do
				expect(response).to redirect_to(new_user_session_path)
			end
			it "has a flash set to log in message" do
				expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
			end
		end

		context "project owner is logged in" do

			before (:each) do
				sign_in user
				user.projects << project1
				@count = Project.count

				delete :destroy, id: project1.id
			end

			it "redirects to profile page after deleting" do
				expect(response).to redirect_to(user_path(user))
			end

			it "should have one less project" do
				expect(Project.count).to eq(@count-1)
			end

			it "should not have the project" do
				expect {Project.find(project1.id)}.to raise_exception(ActiveRecord::RecordNotFound)
			end

			it "should have a flash success" do
				expect(flash[:success]).to eq("Project successfully deleted.")
			end
		end

		context "a different user is logged in" do

			let(:other_user){ FactoryGirl.create(:user2) }

			before (:each) do
				user.projects << project1
				sign_in other_user
				@count = Project.count

				delete :destroy, id: project1.id
			end

			it "redirects to other_user's profile page" do
				expect(response).to redirect_to(user_path(other_user))
			end

			it "should not decrease the count" do
				expect(Project.count).to eq(@count)
			end

			it "should still have the record" do
				expect(Project.find(project1.id).title).to eq(project1.title)
			end

			it "displays a flash warning" do
				expect(flash[:warning]).to eq("You can only make changes to your projects.")
			end
		end
	end
end