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
