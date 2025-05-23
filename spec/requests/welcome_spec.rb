# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/", type: :request do
  context "without login" do
    describe "GET /index" do
      before { get root_url }
      it { expect(response).to have_http_status(:ok) }
    end
  end

  context "login" do
    fixtures :users
    let(:user) { users(:fixture_user_1) }
    before do
      log_in_as(user)
      get root_url
    end
    it { expect(response).to redirect_to(home_url) }
  end
end
