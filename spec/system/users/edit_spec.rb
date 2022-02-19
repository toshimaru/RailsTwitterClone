# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User Edit", type: :system do
  subject { page }

  let(:user) { FactoryBot.create(:user) }

  before do
    log_in_as(user)
    visit edit_user_path(user)
  end

  it "has title and button links" do
    is_expected.to have_title("Edit user")
    is_expected.to have_link("Change", href: "http://gravatar.com/emails")
    is_expected.to have_link("Delete my account", href: user_path(user))
  end

  context "with invalid information" do
    before { click_button "Save changes" }
    it { is_expected.to have_content("too short") }
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

    it "updates successfully" do
      is_expected.to have_title(new_name)
      is_expected.to have_selector("div.alert.alert-success", text: "Profile was successfully updated.")
      is_expected.to have_content(new_name)
      is_expected.to have_content(new_email)
    end
  end

  it "deletes account" do
    expect { click_link "Delete my account" }.to change(User, :count).by(-1)
  end
end
