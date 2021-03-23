# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/sessions", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "GET /new" do
    it "return 200" do
      get login_path
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "redirects to root" do
      post login_path, params: { session: { email: user.email, password: "password" } }
      expect(response).to redirect_to(root_url)
    end

    it "creates a new session with remember_token cookie" do
      post login_path, params: {
        session: { email: user.email, password: "password", remember_me: "1" }
      }
      expect(cookies[:remember_token]).to be_present
    end

    it "creates a new session without remember_token cookie" do
      post login_path, params: {
        session: { email: user.email, password: "password", remember_me: "0" }
      }
      expect(cookies[:remember_token]).to be_nil
    end
  end

  describe "DELETE /destroy" do
    context "after logged in" do
      before { log_in_as(user) }
      it "redirects to root" do
        delete logout_path
        expect(response).to redirect_to(root_url)
      end
    end

    context "no login" do
      it "redirects to root" do
        delete logout_path
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
