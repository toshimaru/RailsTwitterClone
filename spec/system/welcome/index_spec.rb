# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Welcome", type: :system do
  subject { page }

  context "without login" do
    before { visit root_path }

    it "shows home for non-login user" do
      is_expected.to have_title("Welcome")
      is_expected.to have_content("Welcome to Twitter Clone")
      is_expected.to have_link("Sign in")
      is_expected.to have_link("Sign up")
    end

    describe "screenshot", js: true do
      it { page.save_screenshot "non-login-home.png" }
    end
  end
end
