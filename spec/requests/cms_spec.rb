require 'rails_helper'

RSpec.describe "Cms", type: :request do
  describe "GET /view" do
    it "returns http success" do
      get "/cms/view"
      expect(response).to have_http_status(:success)
    end
  end

end
