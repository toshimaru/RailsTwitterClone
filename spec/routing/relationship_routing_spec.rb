# frozen_string_literal: true

require "rails_helper"

RSpec.describe RelationshipsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/relationship").to route_to("relationships#create")
    end

    it "routes to #destroy" do
      expect(delete: "/relationship").to route_to("relationships#destroy")
    end
  end
end
