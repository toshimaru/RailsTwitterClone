# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      get root_url
      expect(response).to be_ok
    end
  end
end
