require "rails_helper"

describe Project do

	before { 
		@user = FactoryGirl.create(:user)
		@project = FactoryGirl.create(:project, user: @user) 
	}

	subject { @project }

	it { should respond_to(:title) }
	it { should respond_to(:description) }
	it { should respond_to(:image) }
	it { should respond_to(:user) }
	it { should respond_to(:project_skills) }

	it { should be_valid }

	describe "when title is not present" do
		before { @project.title = "" }

		it { should_not be_valid }
	end
end
