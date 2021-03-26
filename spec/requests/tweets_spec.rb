# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tweets", type: :request do
  describe "in the Tweets controller" do
    describe "#index" do
      before { get tweets_path }
      it { expect(response).to have_http_status(200) }
    end

    describe "#create" do
      before { post tweets_path }
      it { expect(response).to redirect_to(login_path) }
    end

    describe "#destroy" do
      before { delete tweet_path(1) }
      it { expect(response).to redirect_to(login_path) }
    end
  end
end
