# frozen_string_literal: true

require "rails_helper"

RSpec.describe "User Index", type: :system do
  subject { page }

  describe "Showing active users" do
    let!(:users) { FactoryBot.create_list(:user, 3) }
    let!(:inactive_user) { FactoryBot.create(:user, :inactive) }

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
        is_expected.not_to have_content(inactive_user.name)
      end

      describe "screenshot", js: true do
        it { page.save_screenshot "users.png" }
      end
    end

    context "login" do
      before do
        log_in_as(login_user)
        visit users_path
      end

      context "as non-admin" do
        let(:login_user) { FactoryBot.create(:user) }

        it "lists users with delete link" do
          is_expected.to have_title("Users")
          is_expected.not_to have_content("delete")
          users.each do |user|
            is_expected.to have_link(user.name, href: user_path(user))
          end
          is_expected.not_to have_content(inactive_user.name)
        end
      end

      context "as admin" do
        let(:login_user) { FactoryBot.create(:user, :admin) }

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
end
