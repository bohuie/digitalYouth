require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
	let(:user) { FactoryGirl.create(:user) }

	describe "GET show" do

		context "it finds the user" do

			before(:each) do
				get :show, id: user.id
			end

			it "loads the specified post" do
				expect(assigns(:user)).to eq(user)
			end

			context "the user is an employee" do

				let(:project) { FactoryGirl.create(:project, user: user) }
				let(:reference) { FactoryGirl.create(:reference) }
				let(:skill) { FactoryGirl.create(:skill) }

				before do
					user.add_role(:employee) 
					ProjectSkill.create( project_id: project.id, skill_id: skill.id )
				end

				it "check for employee role" do
					expect(user.has_role?(:employee)).to be_truthy
				end

				it "doesn't have employer role" do
					expect(user.has_role?(:employer)).to be_falsy
				end
			end
		end

		context "the user doesn't exist" do

			before(:each) do
				get :show, id: 1
			end

			it "should redirect to home" do
				expect(response).to redirect_to root_url	#to implement
			end
		end
	end

	describe "associations" do
		let(:skill) { FactoryGirl.create(:skill) }

		before do
			sign_in user
			UserSkill.create( user_id: user.id, skill_id: skill.id )
		end

		it "should destroy associated userskills when user deleted" do
			
			user_skills = user.skills
			user.destroy
			expect(user_skills).to be_empty
		end
	end
end