# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsHelper, type: :helper do
  fixtures :users

  let(:user) { users(:fixture_user_1) }

  describe "#current_user" do
    before { remember(user) }

    it "returns remembered user" do
      expect(current_user).to eq user
    end
  end
end
