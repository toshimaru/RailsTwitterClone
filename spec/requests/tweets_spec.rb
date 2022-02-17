# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/tweets", type: :request do
  describe "GET /index" do
    before { get tweets_path }
    it { expect(response).to be_ok }
  end

  describe "POST /create" do
    before { post tweets_path }
    it { expect(response).to redirect_to(login_path) }
  end

  describe "DELETE /destroy" do
    before { delete tweet_path(1) }
    it { expect(response).to redirect_to(login_path) }
  end
end
