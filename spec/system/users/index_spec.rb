# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User Index", type: :system do
  subject { page }

  describe "Showing all users" do
    let!(:users) { FactoryBot.create_list(:user, 3) }

    context "without login" do
      before do
        visit users_path
      end

      it "lists users" do
        is_expected.to have_title("Users")
        is_expected.not_to have_content("delete")
        users.each do |user|
          is_expected.to have_link(user.name, href: user_path(user))
        end
      end

      describe "screenshot", js: true do
        it { page.save_screenshot "users.png" }
      end
    end

    context "login" do
      let(:admin_user) { FactoryBot.create(:user, :admin) }

      before do
        log_in_as(admin_user)
        visit users_path
      end

      it "lists users with delete link" do
        is_expected.to have_title("Users")
        users.each do |user|
          is_expected.to have_link(user.name, href: user_path(user))
          is_expected.to have_link("delete", href: user_path(user))
        end
      end

      describe "screenshot", js: true do
        it { page.save_screenshot "users-admin.png" }
      end
    end
  end
end
