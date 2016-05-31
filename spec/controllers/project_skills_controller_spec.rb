require 'rails_helper'

RSpec.describe ProjectSkillsController, type: :controller do 

	let(:user) { FactoryGirl.create(:user) }
	let(:project) { FactoryGirl.create(:project, user: user) }
	let(:skill) { FactoryGirl.create(:skill) }

	describe "POST create" do

		context "user is not logged in" do
			before (:each) do
				post :create
			end

			it "redirects to user page" do
				expect(response).to redirect_to(new_user_session_path)
			end 
		end

		context "project owner is logged in and successfully creates the relation" do
			before(:each) do
				user.projects << project
				sign_in user
				@count = ProjectSkill.count

				post :create, project_skill: { project_id: project.id, name: skill.name }
			end

			it "should direct back to the edit project page" do
				expect(response).to redirect_to(edit_project_path(project))
			end

			it "should have increased the count" do
				expect(ProjectSkill.count).to eq(@count+1)
			end

			it "should have it" do
				expect(ProjectSkill.where(project_id: project.id, skill_id: skill.id)).to exist
			end
		end

		context "some other user is logged in" do

			let(:other_user) { FactoryGirl.create(:user2) }

			before(:each) do
				user.projects << project
				sign_in other_user
				@count = ProjectSkill.count

				post :create, project_skill: { project_id: project.id, name: skill.name }
			end

			it "should direct to other_user path" do
				expect(response).to redirect_to(user_path(other_user))
			end

			it "should not have increased the count" do
				expect(ProjectSkill.count).to eq(@count)
			end

			it "should not have it" do
				expect(ProjectSkill.where(project_id: project.id, skill_id: skill.id)).to_not exist
			end

			it "should have a warning flash" do
				expect(flash[:warning]).to eq('Access denied as you are not owner of this Project')
			end
		end

		context "project skill is not created properly" do
			before(:each) do
				user.projects << project
				sign_in user
				@count = ProjectSkill.count

				post :create, project_skill: { project_id: project.id, name: "" }
			end

			it "should direct to user path" do
				expect(response).to redirect_to(user_path(user))
			end

			it "should not have increased the count" do
				expect(ProjectSkill.count).to eq(@count)
			end

			it "should not have it" do
				expect(ProjectSkill.where(project_id: project.id, skill_id: skill.id)).to_not exist
			end

			it "should have a danger flash" do
				expect(flash[:danger]).to eq("Something went wrong. Please try again later or contact an administrator.")
			end
		end
	end
end