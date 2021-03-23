# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Tweet pages", type: :system do
  subject { page }

  # NOTE: Use `let!` to avoid `exception: #<BCrypt::Errors::InvalidHash: invalid hash>`
  let!(:user) { FactoryBot.create(:user) }
  before { log_in_as(user) }

  describe "show all tweets" do
    let!(:tweet1) { FactoryBot.create(:tweet, user: user, content: "Harakiri") }
    let!(:tweet2) { FactoryBot.create(:tweet, user: user, content: "Samurai") }
    let!(:tweet3) { FactoryBot.create(:tweet, user: user, content: "Ninja") }
    let!(:tweet4) { FactoryBot.create(:tweet, user: user, content: "a" * 70) }

    before { visit tweets_path }

    it { should have_selector("h2", text: "Tweets") }
    it { should have_content(tweet1.content) }
    it { should have_content(tweet2.content) }
    it { should have_content(tweet3.content) }
    it { should have_content(tweet4.content) }

    describe "screenshot", js: true do
      it { page.save_screenshot "tweets.png" }
    end
  end

  describe "tweet creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a tweet" do
        expect { click_button "Post" }.not_to change(Tweet, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content("can't be blank") }
      end
    end

    describe "with valid information" do
      before { fill_in "tweet_content", with: "Lorem ipsum" }
      it "should create a tweet" do
        expect { click_button "Post" }.to change(Tweet, :count).by(1)
      end
    end
  end

  describe "tweet destroy" do
    before { FactoryBot.create(:tweet, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a tweet" do
        expect { click_link "delete" }.to change(Tweet, :count).by(-1)
      end
    end
  end
end
