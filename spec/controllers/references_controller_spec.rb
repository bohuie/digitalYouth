require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do 

	describe "GET show" do

		let(:reference1) { FactoryGirl.create(:reference1) }
		let(:reference2) { FactoryGirl.create(:reference2) }

		it "loads the specified reference" do
			get :show, id: reference1.id

			expect(assigns(:reference1)).to eq(reference1)
		end
	end

end