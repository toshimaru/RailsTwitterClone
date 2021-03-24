# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users").to route_to("users#index")
    end

    it "routes to #new" do
      expect(get: "/signup").to route_to("users#new")
    end

    it "routes to #show" do
      expect(get: "/users/username").to route_to("users#show", id: "username")
      expect(get: "/users/new").to route_to("users#show", id: "new")
    end

    it "routes to #edit" do
      expect(get: "/users/username/edit").to route_to("users#edit", id: "username")
    end

    it "routes to #create" do
      expect(post: "/users").to route_to("users#create")
    end

    it "routes to #destroy" do
      expect(delete: "/users/username").to route_to("users#destroy", id: "username")
    end

    it "routes to #followers" do
      expect(get: "/users/username/followers").to route_to("users#followers", id: "username")
    end

    it "routes to #following" do
      expect(get: "/users/username/following").to route_to("users#following", id: "username")
    end
  end
end
