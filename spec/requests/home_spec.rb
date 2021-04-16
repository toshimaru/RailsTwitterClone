# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/ (root)", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "GET /index" do
    context "login" do
      before { log_in_as(user) }
      it "renders a successful response" do
        get root_url
        expect(response).to be_successful
      end
    end

    context "without login" do
      it "renders a successful response" do
        get root_url
        expect(response).to be_successful
      end
    end
  end
end
