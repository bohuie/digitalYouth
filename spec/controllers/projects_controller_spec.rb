require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do 

	describe "GET show" do

		let(:project1) { FactoryGirl.create(:project) }
		let(:project2) { FactoryGirl.create(:project) }

		it "loads the specified post" do
			get :show, id: project1.id

			expect(assigns(:project)).to eq(project1)
		end
	end

	describe "GET new" do

		let(:user) { FactoryGirl.create(:user) }
		let(:project1) { Project.create! }

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
		let(:project1) { Project.create! }
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

		context "user is logged in and it is their project" do

			it "loads the page" do
				user.projects << project1
				sign_in user
				get :edit, id: project1.id

				expect(response).to render_template(:edit)
			end

			it "goes to create on submission" do
				user.projects << project1
				sign_in user
				get :edit, id: project1.id

				
			end
		end
	end

	describe "POST create" do

		let(:project1) { Project.create! }


		it "redirects when not logged in" do
			post :create

			expect(response).to redirect_to(new_user_session_path)
		end

		context "user is logged in" do
			let(:user) { FactoryGirl.create(:user) }
			let(:project1) { Project.create! }
			let(:old_title) { project1.title }
			let(:user2) { FactoryGirl.create(:user2) }

			before(:each) do { project1.title => "New Title" } end

			it "should load the page" do
				user.projects << project1
				sign_in user

				project_attr = { title: project1.title, description: project1.description, image: nil }
				post :create, project: project_attr 

				expect(response).to redirect_to(user_path(user))
			end
		end
	end

	describe "PATCH update" do

		let(:project1) { Project.create! }

		it "redirects when not logged in" do
			patch :update, id: project1.id

			expect(response).to redirect_to(new_user_session_path)
		end

		context "user is logged in" do
			let(:user) { FactoryGirl.create(:user) }
			let(:project1) { FactoryGirl.create(:project) }
			let(:old_title) { project1.title }
			let(:user2) { FactoryGirl.create(:user2) }

			it "should load the page" do
				user.projects << project1
				sign_in user

				project_attr = { title: project1.title, description: project1.description, image: nil }
				patch :update, id: project1.id, project: project_attr

				expect(response).to redirect_to(user_path(user))
			end
		end
	end
end