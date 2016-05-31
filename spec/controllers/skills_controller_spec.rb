require 'rails_helper'

RSpec.describe SkillsController, type: :controller do 

	describe "associations" do
		let(:user) { FactoryGirl.create(:user) }
		let(:project) { FactoryGirl.create(:project, user: user) }
		let(:skill) { FactoryGirl.create(:skill) }

		before do
			sign_in user
			ProjectSkill.create( project_id: project.id, skill_id: skill.id )
		end

		it "should destroy associated projectskills when projects deleted" do
			project_skills = project.project_skills
			project.destroy
			expect(project_skills).to be_empty
			project_skills.each do |project_skill|
				expect(ProjectSkill.find_by_id(project_skill.id)).to be_nil
			end
		end
	end
end
