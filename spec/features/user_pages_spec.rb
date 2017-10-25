# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UserPages", type: :feature do
  subject { page }

  let(:user) { FactoryBot.create(:user) }

  describe "Show all users (/users)" do
    before do
      FactoryBot.create(:user, name: "Bob", email: "bob@example.com")
      FactoryBot.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_content("Users") }
    it { should have_title("Users") }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector("li", text: user.name)
      end
    end
  end

  describe "/signup" do
    before { visit signup_path }
    let(:submit) { "Sign up" }

    it { should have_content("Sign up") }

    context "with valid information" do
      before do
        fill_in "Name",                  with: "Example User"
        fill_in "Slug",                  with: "example-user"
        fill_in "Email",                 with: "user@example.com"
        fill_in "Password",              with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: "user@example.com") }

        it { should have_link("Sign out") }
        it { should have_selector("div.alert.alert-success", text: "Welcome") }
        it { should have_title(user.name) }
      end
    end

    context "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
  end

  describe "edit" do
    before do
      log_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link("change", href: "http://gravatar.com/emails") }
      it { should have_link("Delete my account", href: user_path(user)) }
    end

    context "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content("too short") }
    end

    context "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }

      before do
        fill_in "Name",                  with: new_name
        fill_in "Email",                 with: new_email
        fill_in "Password",              with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_link("Profile",     href: user_path(user)) }
      it { should have_link("Setting",     href: edit_user_path(user)) }
      it { should have_link("Sign out",    href: signout_path) }
      it { should_not have_link("Sign in", href: signin_path) }
      it { should have_selector("div.alert.alert-success") }
      it { expect(user.reload.name).to  eq new_name }
      it { expect(user.reload.email).to eq new_email }
    end

    context "delete account" do
      specify do
        expect do
          click_link "Delete my account"
        end.to change(User, :count).by(-1)
      end
    end
  end

  describe "profile page (/user/:id)" do
    let!(:m1) { FactoryBot.create(:tweet, user: user, content: "Foo") }
    let!(:m2) { FactoryBot.create(:tweet, user: user, content: "Bar") }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    it { should have_content(m1.content) }
    it { should have_content(m2.content) }
    it { should have_content(user.tweets.count) }

    it { should_not have_selector("textarea") }
    it { should_not have_field("tweet[content]") }

    describe "sign in user have tweet" do
      before do
        log_in user
        visit user_path(user)
      end

      it { should have_selector("textarea") }
      it { should have_field("tweet[content]") }
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryBot.create(:user) }
      before { log_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
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
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
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
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        log_in user
        visit following_user_path(user)
      end

      it { should have_title("Following") }
      it { should have_selector("h2", text: "Following") }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe "followers" do
      before do
        log_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_title("Followers") }
      it { should have_selector("h2", text: "Followers") }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
end
