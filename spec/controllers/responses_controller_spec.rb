require 'rails_helper'

RSpec.describe ResponsesController, type: :controller do
	describe "GET show" do

		it "loads the survey" do
			let(:survey1) { FactoryGirl.create(:survey) }
			get :show, title: 

			expect(assigns(:survey)).to eq(survey1)
		end
	end
end
