# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Authentication", type: :system do
  subject { page }

  describe "authorization" do
    before { visit login_path }

    it { is_expected.to have_title("Sign in") }

    describe "screenshot", js: true do
      it { page.save_screenshot "login-page.png" }
    end

    context "with invalid information" do
      before { click_button "Sign in" }

      it "shows error message" do
        is_expected.to have_title("Sign in")
        is_expected.to have_selector("div.alert.alert-danger", text: "Invalid email/password combination")
      end

      describe "after visiting another page" do
        before { visit root_path }
        it { is_expected.not_to have_selector("div.alert.alert-danger") }
      end
    end

    context "with valid information" do
      let(:user) { FactoryBot.create(:user) }

      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it "shows navigation menu" do
        is_expected.to have_title("Home")
        is_expected.to have_link("Users", href: users_path)
        is_expected.to have_link("Profile", href: user_path(user))
        is_expected.to have_link("Tweets", href: tweets_path)
        is_expected.to have_link("Sign out", href: logout_path)
        is_expected.not_to have_link("Sign in", href: login_path)
      end

      describe "followed by logout" do
        before { click_link "Sign out" }
        it { is_expected.to have_link("Sign in") }
      end
    end

    context "without login" do
      let(:user) { FactoryBot.create(:user) }

      describe "in the Users Controller" do
        describe "visit the following page" do
          before { visit following_user_path(user) }
          it { is_expected.to have_title("Following") }
        end

        describe "visit the followers page" do
          before { visit followers_user_path(user) }
          it { is_expected.to have_title("Followers") }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { is_expected.to have_title("Users") }

          describe "screenshot", js: true do
            it { page.save_screenshot "users.png" }
          end
        end
      end
    end
  end
end
