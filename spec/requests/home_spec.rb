# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/home", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "GET /index" do
    context "login" do
      before {
        log_in_as(user)
        get home_url
      }
      it { expect(response).to be_ok }
    end

    context "without login" do
      before { get home_url }
      it { expect(response).to redirect_to login_url }
    end
  end
end
