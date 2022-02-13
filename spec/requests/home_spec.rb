# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/home", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "GET /index" do
    context "login" do
      before { log_in_as(user) }
      it "renders a 200 response" do
        get home_url
        expect(response).to be_ok
      end
    end

    context "without login" do
      it "redirects to login page" do
        get home_url
        expect(response).to redirect_to login_url
      end
    end
  end
end
