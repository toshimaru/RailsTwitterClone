# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "#new" do
    context "GET" do
      it "has a 200 status code" do
        get new_session_path
        expect(response.status).to eq(200)
      end
    end
  end
end
