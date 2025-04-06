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
end
