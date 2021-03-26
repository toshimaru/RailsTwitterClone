# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Static Pages", type: :system do
  fixtures :users

  subject { page }

  describe "Home" do
    describe "for log in users" do
      let(:user) { FactoryBot.create(:user) }

      before do
        FactoryBot.create_list(:tweet, 2, user: user, content: Faker::Quote.famous_last_words)
        log_in_as(user)
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          should have_content(item.content)
        end
      end

      it { should have_title "Home" }
      it { should have_selector("textarea") }
      it { should have_field("tweet[content]") }

      describe "follower/following counts" do
        let(:other_user) { users(:fixture_user_1) }

        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0", href: following_user_path(user)) }
        it { should have_link("1", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help" do
    before { visit help_path }
    it { should have_title "Help" }
  end

  describe "About" do
    before { visit about_path }
    it { should have_title "About" }
  end

  describe "Contact" do
    before { visit contact_path }
    it { should have_title "Contact" }
  end
end
