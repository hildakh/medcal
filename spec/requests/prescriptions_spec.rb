require 'rails_helper'

RSpec.describe "Prescriptions", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/prescriptions/create"
      expect(response).to have_http_status(:success)
    end
  end
end
