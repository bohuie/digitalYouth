require 'rails_helper'

RSpec.describe ReferencesController, type: :controller do 

	describe "GET show" do
		let(:reference1) { FactoryGirl.create(:reference1) }

		it "loads the specified reference" do
			get :show, id: reference1.id
			byebug
			expect(assigns(:unconfirmed_references)).to eq(reference1)
		end
	end

	describe "GET new" do

		let(:reference1) { FactoryGirl.create(:reference1) }

		it "redirects to root if the phrase is not in the db" do
			get :new, id:"phrase"

			expect(response).to redirect_to(root_path)
		end

	end

end