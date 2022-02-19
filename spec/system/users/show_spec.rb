# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User Show", type: :system do
  subject { page }

  let(:user) { FactoryBot.create(:user) }

  context "without login" do
    let!(:tweet1) { FactoryBot.create(:tweet, user: user) }
    let!(:tweet2) { FactoryBot.create(:tweet, user: user) }

    before { visit user_path(user) }

    it "shows the user's info" do
      is_expected.to have_title(CGI.escapeHTML(user.name))
      is_expected.to have_content(user.name)
      is_expected.to have_content(user.email)
      is_expected.to have_content(user.tweets.count)
    end

    it "shows tweets" do
      is_expected.to have_content(tweet1.content)
      is_expected.to have_content(tweet2.content)
    end

    it "doesn't show tweet form" do
      is_expected.not_to have_selector("textarea")
      is_expected.not_to have_field("tweet[content]")
    end
  end

  context "login" do
    before { log_in_as(user) }

    describe "showing my page" do
      before { visit user_path(user) }

      it "shows tweet form" do
        is_expected.to have_title(CGI.escapeHTML(user.name))
        is_expected.to have_content(user.name)
        is_expected.to have_content(user.email)
        is_expected.to have_selector("textarea")
        is_expected.to have_field("tweet[content]")
      end
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryBot.create(:user) }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "doesn't show tweet form" do
          is_expected.not_to have_selector("textarea")
          is_expected.not_to have_field("tweet[content]")
        end

        it "increments the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.following, :count).by(1)
        end

        it "increments the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { is_expected.to have_xpath("//input[@value='Unfollow']") }
        end
      end

      describe "unfollowing a user" do
        before do
          FactoryBot.create(:relationship, follower: user, followed: other_user)
          visit user_path(other_user)
        end

        it "decrements the followed user count" do
          expect {
            click_button "Unfollow"
          }.to change(user.following, :count).by(-1)
        end

        it "decrements the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { is_expected.to have_xpath("//input[@value='Follow']") }
        end
      end
    end
  end
end
