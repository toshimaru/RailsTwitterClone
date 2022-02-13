# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Authentication", type: :system do
  fixtures :users

  subject { page }

  describe "authorization" do
    before { visit login_path }

    it { should have_title("Sign in") }

    describe "screenshot", js: true do
      it { page.save_screenshot "login-page.png" }
    end

    context "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title("Sign in") }
      it { should have_selector("div.alert.alert-danger") }

      describe "after visiting another page" do
        before { visit root_path }
        it { should_not have_selector("div.alert.alert-danger") }
      end
    end

    context "with valid information" do
      let(:user) { FactoryBot.create(:user) }

      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title("Home") }
      it { should have_link("Users", href: users_path) }
      it { should have_link("Profile", href: user_path(user)) }
      it { should have_link("Tweets", href: tweets_path) }
      it { should have_link("Sign out", href: logout_path) }
      it { should_not have_link("Sign in", href: login_path) }

      describe "followed by logout" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
    end

    context "without login" do
      let(:user) { FactoryBot.create(:user) }

      describe "when attempting to visit a protected page" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_content("Sign in") }
        end
      end

      describe "in the Users Controller" do
        describe "visit the following page" do
          before { visit following_user_path(user) }
          it { should have_title("Following") }
        end

        describe "visit the followers page" do
          before { visit followers_user_path(user) }
          it { should have_title("Followers") }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title("Users") }

          describe "screenshot", js: true do
            it { page.save_screenshot "users.png" }
          end
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryBot.create(:user) }
      let(:wrong_user) { users(:fixture_user_1) }
      before { log_in_as(user) }

      describe "Visit wrong_user's edit page" do
        before { visit edit_user_path(wrong_user) }

        it { should_not have_content("Update your profile") }
        it { should have_content("Sign out") }
      end
    end
  end
end
