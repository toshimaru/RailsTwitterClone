# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :system do
  subject { page }

  context "login" do
    let(:user) { FactoryBot.create(:user) }

    before { log_in_as(user) }

    describe "Timeline" do
      before do
        FactoryBot.create_list(:tweet, 3, user: user, content: Faker::Quote.famous_last_words)
        visit root_path
      end

      it "renders the user's feed" do
        is_expected.to have_title "Home"
        user.feed.each do |item|
          is_expected.to have_content(item.content)
        end
      end
    end

    describe "Tweet creation" do
      let(:tweet) { Faker::Quote.famous_last_words }

      before {
        visit root_path
        fill_in "tweet_content", with: tweet
      }

      it "creates a tweet" do
        expect { click_button "Post" }.to change(Tweet, :count).by(1)
        is_expected.to have_content "Tweet created!"
        is_expected.to have_content(tweet)
      end
    end

    describe "Tweets/Followings/Followings" do
      fixtures :users
      let(:other_user) { users(:fixture_user_1) }

      before {
        FactoryBot.create_list(:tweet, 2, user: user, content: Faker::Quote.famous_last_words)
        user.follow(other_user)
        visit root_path
      }

      it "shows Tweets/Followings/Followings with the number" do
        within ".stats" do
          is_expected.to have_link("2", href: user_path(user))
          is_expected.to have_link("1", href: following_user_path(user))
          is_expected.to have_link("0", href: followers_user_path(user))
        end
      end
    end
  end

  context "without login" do
    before { visit root_path }

    it "redirects to welcome page" do
      is_expected.to have_title("Welcome")
      is_expected.to have_content("Welcome to Twitter Clone")
      is_expected.to have_link("Sign in")
      is_expected.to have_link("Sign up")
    end
  end
end
