# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UserPages", type: :system do
  subject { page }

  let(:user) { FactoryBot.create(:user) }

  describe "/signup" do
    before { visit signup_path }

    it { should have_title("Sign up") }
    it { should have_content("Sign up") }

    context "with valid information" do
      let(:user_email) { "user@example.com" }
      let(:user_name) { "Example User Name" }

      before do
        fill_in "Slug",                  with: "example-user"
        fill_in "Name",                  with: user_name
        fill_in "Email",                 with: user_email
        fill_in "Password",              with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button "Sign up" }

        it { should have_link("Sign out") }
        it { should have_selector("div.alert.alert-success", text: "Welcome") }
        it { should have_title(user_name) }
      end
    end

    context "with invalid information" do
      it "should not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end

      describe "error message" do
        before { click_button "Sign up" }

        it { should have_content "Name can't be blank" }
        it { should have_content "Email can't be blank" }
        it { should have_content "Password can't be blank" }
        it { should have_content "Password is too short" }
      end
    end
  end

  describe "profile page (/user/:id)" do
    let!(:m1) { FactoryBot.create(:tweet, user: user, content: "Foo") }
    let!(:m2) { FactoryBot.create(:tweet, user: user, content: "Bar") }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(CGI.escapeHTML(user.name)) }

    it { should have_content(m1.content) }
    it { should have_content(m2.content) }
    it { should have_content(user.tweets.count) }

    it { should_not have_selector("textarea") }
    it { should_not have_field("tweet[content]") }

    describe "Sign in user have tweet" do
      before do
        log_in_as(user)
        visit user_path(user)
      end

      it { should have_selector("textarea") }
      it { should have_field("tweet[content]") }
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryBot.create(:user) }
      before { log_in_as(user) }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.following, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_xpath("//input[@value='Unfollow']") }
        end
      end

      describe "unfollowing a user" do
        before {
          FactoryBot.create(:relationship, follower: user, followed: other_user)
          visit user_path(other_user)
        }

        it "should decrement the followed user count" do
          expect {
            click_button "Unfollow"
          }.to change(user.following, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_xpath("//input[@value='Follow']") }
        end
      end
    end
  end

  describe "following/followers" do
    let(:other_user) { FactoryBot.create(:user) }
    before { FactoryBot.create(:relationship, follower: user, followed: other_user) }

    describe "followed users" do
      before {
        log_in_as(user)
        visit following_user_path(user)
      }

      it { is_expected.to have_title("Following") }
      it { is_expected.to have_selector("h2", text: "Following") }
      it { is_expected.to have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        log_in_as other_user
        visit followers_user_path(other_user)
      end

      it { should have_title("Followers") }
      it { should have_selector("h2", text: "Followers") }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
end
