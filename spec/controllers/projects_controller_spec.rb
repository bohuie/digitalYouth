require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do 

	describe "GET show" do

		let(:project1) { FactoryGirl.create(:project) }

		it "loads the specified post" do
			get :show, id: project1.id
			expect(assigns(:project)).to eq(project1)
		end
	end

	describe "GET new" do

		let(:user) { FactoryGirl.create(:user) }
		let(:project1) { FactoryGirl.create(:project) }

		it "redirects the user when not logged in" do
			get :new

			expect(response).to redirect_to(new_user_session_path)
		end

		it "loads the page when logged in" do
			user.projects << project1
			sign_in user

			get :new

			expect(response).to render_template(:new)
		end
	end

	describe "GET edit" do

		let(:user) { FactoryGirl.create(:user) }
		let(:project1) { FactoryGirl.create(:project) }
		let(:user2) { FactoryGirl.create(:user2) }

		it "redirects the user when not logged in" do
			get :edit, id: project1.id

			expect(response).to redirect_to(new_user_session_path)
		end

		it "redirects if it is not the owner's project" do
			user.projects << project1
			sign_in user2

			get :edit, id: project1.id

			expect(response).to redirect_to(user_path(user))
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

			it "redirects to user's page" do
				expect(response).to redirect_to(user_path(user))
			end
		end
	end

	describe "POST create" do

		let(:project1) { FactoryGirl.build(:project) }
		let(:user) { FactoryGirl.create(:user) }
		let(:project_attr) { { title: project1.title, description: project1.description, image: nil } }


		it "redirects when not logged in" do
			post :create

			expect(response).to redirect_to(new_user_session_path)
		end

		context "project owner is logged in" do

			before(:each) do
				user.projects << project1
				sign_in user
				post :create, id: project1.id, project: project_attr
			end

			it "should load the page" do
				expect(response).to redirect_to(user_path(user))
			end
		end

		context "project owner creates the project" do

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
		end

		context "other user is logged in" do
			let(:other_user) { FactoryGirl.create(:user2) }

			before (:each) do
				user.projects << project1
				sign_in other_user

				post :create, id: project1.id, project: project_attr
			end

			it "redirects to user's page" do
				expect(response).to redirect_to(user_path(user))
			end
		end
	end

	describe "PATCH update" do

		let(:project1) { FactoryGirl.create(:project) }
		let(:user) { FactoryGirl.create(:user) }
		let(:new_title) { "Hello!" }
		let(:project_attr) { {title: new_title, description: project1.description, image: nil} }

		it "redirects when not logged in" do
			patch :update, id: project1.id

			expect(response).to redirect_to(new_user_session_path)
		end

		context "project owner is logged in" do

			before (:each) do
				user.projects << project1
				sign_in user

				patch :update, id: project1.id, project: project_attr
			end

			it "should load the page" do
				expect(response).to redirect_to(user_path(user))
			end

			it "should have the new information" do
				expect(Project.last.title).to eq(new_title)
			end
		end

		context "other user is logged in" do
			let(:other_user) { FactoryGirl.create(:user2) }

			before (:each) do
				user.projects << project1
				sign_in other_user

				patch :update, id: project1.id, project: project_attr
			end

			it "redirects to user's page" do
				expect(response).to redirect_to(user_path(user))
			end
		end
	end

	describe "DELETE delete" do

		let(:project1) { FactoryGirl.create(:project) }
		let(:user) { FactoryGirl.create(:user) }
		let(:project_attr) { { title: project1.title, description: project1.description, image: nil } }

		before (:each) do 
			user.projects << project1
		end

		it "redirects when not logged in" do
			post :create

			expect(response).to redirect_to(new_user_session_path)
		end

		context "project owner is logged in" do

			before (:each) do
				
				sign_in user
			end
		end
	end
end