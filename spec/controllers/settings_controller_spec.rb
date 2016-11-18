require 'rails_helper'

RSpec.describe SettingsController, type: :controller do

  describe "GET #consent" do
    it "returns http success" do
      get :consent
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #privacy" do
    it "returns http success" do
      get :privacy
      expect(response).to have_http_status(:success)
    end
  end

end
