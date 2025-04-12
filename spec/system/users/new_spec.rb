# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User signup", type: :system do
  subject { page }

  describe "/signup" do
    before { visit signup_path }

    it "shows sign up page" do
      is_expected.to have_title("Sign up")
      is_expected.to have_content("Sign up")
    end

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

      it "creates a user" do
        click_button "Sign up"
        created_user = User.find_by!(email: user_email)
        expect(created_user.activated).to be false
        expect(created_user.activated).to be false
        expect(created_user.activated_at).to be_nil
        expect(created_user.activation_digest).to start_with("$2a$")
        is_expected.to have_content "Please check your email to activate your account."
      end
    end

    context "with invalid information" do
      it "does not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end

      before { click_button "Sign up" }

      it "shows error messages" do
        is_expected.to have_content "Name can't be blank"
        is_expected.to have_content "Email can't be blank"
        is_expected.to have_content "Password can't be blank"
        is_expected.to have_content "Password is too short"
      end
    end
  end
end
