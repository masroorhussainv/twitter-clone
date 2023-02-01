require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
    it "is successful" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
