require 'rails_helper'

RSpec.describe ProjectSkillsController, type: :controller do 

	describe "POST create" do
		let(:project) { FactoryGirl.create(:project) }
		let(:skill) { FactoryGirl.create(:skill) }
		let(:user) { FactoryGirl.create(:user) }

		context "user is not logged in" do
			before (:each) do
				post :create
			end

			it "redirects to user page" do
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "project owner is logged in" do
			before(:each) do
				user.projects << project
				sign_in user

				post :create, project_skill: { project_id: project.id, name: skill.name }
			end

			it "should direct back to the edit project page" do
				expect(response).to redirect_to(edit_project_path(project))
			end
		end
	end
end