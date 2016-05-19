require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do 

	describe "GET show" do
		it "loads the specified post" do
			project1 = Project.create!
			project2 = Project.create!
			get :show, id: project1.id

			expect(assigns(:project)).to eq(project1)
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

		it "redirects if it is not the owner's project" do\
			
			user.projects << project1

			sign_in user2

			get :edit, id: project1.id

			expect(response).to redirect_to(user_path(user))
		end
	end

end