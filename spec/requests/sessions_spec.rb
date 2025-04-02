# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/sessions", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "GET /new" do
    before { get login_url }
    it { expect(response).to have_http_status(:ok) }
  end

  describe "POST /create" do
    let(:email) { user.email }
    let(:password) { "password" }

    it "redirects to home" do
      post login_url, params: { session: { email: email, password: password } }
      expect(response).to redirect_to(home_url)
    end

    it "creates a new session with remember_token cookie" do
      post login_url, params: { session: { email: email, password: password, remember_me: "1" } }
      expect(cookies[:remember_token]).to be_present
    end

    it "creates a new session without remember_token cookie" do
      post login_url, params: { session: { email: email, password: password, remember_me: "0" } }
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

    context "Session Replay" do
      before { log_in_as(user) }
      it "prevents session replay attack" do
        session_cookie = cookies["_rails_twitter_clone_session"]
        get home_path
        expect(response).to have_http_status(:ok)

        delete logout_path
        cookies["_rails_twitter_clone_session"] = session_cookie
        get home_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
