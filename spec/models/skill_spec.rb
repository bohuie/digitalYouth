require "rails_helper"

describe Skill do

	before {
		@skill = FactoryGirl.create(:skill)
	}

	subject { @skill }

	it { should respond_to(:name) }

	it { should be_valid }

	describe "when there is no name" do
		before { @skill.name = "" }

		it { should_not be_valid }
	end

	it "duplicated name" do
		expect(FactoryGirl.build(:skill)).to_not be_valid
	end
end