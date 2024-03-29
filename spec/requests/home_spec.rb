require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    
    context "when user is not signed in" do
      it "is successful" do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is signed in" do
      it "redirects to dashboard" do
        user = create(:user)
        sign_in user
        get root_path
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
