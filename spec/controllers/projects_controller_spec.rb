require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do 

	describe "GET show" do
		it "loads the specified post" do
			project1 = Project.create!
			get :show, id: project1.id

			expect(assigns(:project)).to eq(project1)
		end
	end
end