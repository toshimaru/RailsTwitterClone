# frozen_string_literal: true

require "rails_helper"

RSpec.describe TweetsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tweets").to route_to("tweets#index")
    end

    it "routes to #create" do
      expect(post: "/tweets").to route_to("tweets#create")
    end

    it "routes to #destroy" do
      expect(delete: "/tweets/1").to route_to("tweets#destroy", id: "1")
    end
  end
end
