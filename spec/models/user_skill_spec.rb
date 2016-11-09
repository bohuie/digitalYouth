require "rails_helper"
include ConstantHelper

describe UserSkill do

	let(:user) { FactoryGirl.create(:user) }
	let(:skill) { FactoryGirl.create(:skill) }

	before {
		user.confirm
	}

	context "correctly creates skills" do
		let(:user_skill) { UserSkill.create(user_id: user.id, skill_id: skill.id, rating: 1) }

		subject { user_skill }

		it { should respond_to(:user_id) }
		it { should respond_to(:skill_id) }
		it { should respond_to(:rating) }

		it { should be_valid}
	end

	context "fails to create connection" do
		it "errors with skills above max_rating" do
			expect(UserSkill.create(user_id:user.id, skill_id:skill.id, rating: 5)).to_not be_valid
		end
	end
end