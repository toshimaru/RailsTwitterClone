# frozen_string_literal: true

require "rails_helper"

RSpec.describe WelcomeController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/").to route_to("welcome#index")
    end
  end
end
