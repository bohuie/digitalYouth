require 'rails_helper'

RSpec.describe SkillsController, type: :controller do 

	describe "associations" do
		let(:user) { FactoryGirl.create(:user) }
		let(:project) { FactoryGirl.create(:project, user: user) }
		let(:skill) { FactoryGirl.create(:skill) }

		before do
			user.confirm
			sign_in user
			ProjectSkill.create( project_id: project.id, skill_id: skill.id )
			UserSkill.create( user_id: user.id, skill_id: skill.id )
		end

		it "should destroy associated projectskills when skills deleted" do
			project_skills = skill.project_skills
			skill.destroy
			expect(project_skills).to be_empty
			expect(Project.find(project.id).title).to eq(project.title)
		end

		it "should destroy associated userskills when user deleted" do
			user_skills = skill.user_skills
			skill.destroy
			expect(user_skills).to be_empty
			expect(User.find(user.id).email).to eq(user.email)
		end
	end
end
