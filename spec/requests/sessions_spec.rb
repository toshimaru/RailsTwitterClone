# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/sessions", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "GET /new" do
    before { get login_url }
    it { expect(response).to be_ok }
  end

  describe "POST /create" do
    it "redirects to root" do
      post login_url, params: { session: { email: user.email, password: "password" } }
      expect(response).to redirect_to(home_url)
    end

    it "creates a new session with remember_token cookie" do
      post login_url, params: {
        session: { email: user.email, password: "password", remember_me: "1" }
      }
      expect(cookies[:remember_token]).to be_present
    end

    it "creates a new session without remember_token cookie" do
      post login_url, params: {
        session: { email: user.email, password: "password", remember_me: "0" }
      }
      expect(cookies[:remember_token]).to be_nil
    end
  end

  describe "DELETE /destroy" do
    context "login" do
      before {
        log_in_as(user)
        delete logout_path
      }
      it { expect(response).to redirect_to(root_url) }
    end

    context "without login" do
      before { delete logout_path }
      it { expect(response).to redirect_to(root_url) }
    end
  end
end
