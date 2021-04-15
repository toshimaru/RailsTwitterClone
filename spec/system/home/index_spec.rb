# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :system do
  fixtures :users

  subject { page }

  describe "for log in users" do
    let(:user) { FactoryBot.create(:user) }

    before do
      FactoryBot.create_list(:tweet, 2, user: user, content: Faker::Quote.famous_last_words)
      log_in_as(user)
      visit root_path
    end

    it "renders the user's feed" do
      user.feed.each do |item|
        is_expected.to have_content(item.content)
      end
    end

    it "shows home" do
      is_expected.to have_title "Home"
      is_expected.to have_selector("textarea")
      is_expected.to have_field("tweet[content]")
    end

    describe "follower/following counts" do
      let(:other_user) { users(:fixture_user_1) }

      before {
        FactoryBot.create(:relationship, follower: other_user, followed: user)
        visit root_path
      }

      it { is_expected.to have_link("0", href: following_user_path(user)) }
      it { is_expected.to have_link("1", href: followers_user_path(user)) }
    end
  end
end
