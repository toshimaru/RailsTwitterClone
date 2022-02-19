# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User Index", type: :system do
  subject { page }

  describe "Showing all users" do
    before do
      FactoryBot.create_list(:user, 3)
      visit users_path
    end

    it "lists users" do
      is_expected.to have_title("Users")
      is_expected.to have_content("Users")
      User.all.each do |user|
        expect(page).to have_selector("li", text: user.name)
      end
    end
  end
end
