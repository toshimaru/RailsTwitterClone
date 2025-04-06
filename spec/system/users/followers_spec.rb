# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Followers", type: :system do
  subject { page }

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before { FactoryBot.create(:relationship, follower: user, followed: other_user) }

  describe "followers page" do
    before do
      log_in_as(other_user)
      visit followers_user_path(other_user)
    end

    it { is_expected.to have_title("Followers") }
    it { is_expected.to have_selector("h2", text: "Followers") }
    it { is_expected.to have_link(user.name, href: user_path(user)) }
  end
end
