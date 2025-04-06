# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Following", type: :system do
  subject { page }

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before { FactoryBot.create(:relationship, follower: user, followed: other_user) }

  describe "following page" do
    before do
      visit following_user_path(user)
    end

    it { is_expected.to have_title("Following") }
    it { is_expected.to have_selector("h2", text: "Following") }
    it { is_expected.to have_link(other_user.name, href: user_path(other_user)) }
  end
end
