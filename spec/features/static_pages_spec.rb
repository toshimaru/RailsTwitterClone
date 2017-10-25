# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Static Pages", type: :feature do
  subject { page }

  describe "Home Page" do
    describe "for signed in users" do
      let(:user) { FactoryBot.create(:user) }

      before do
        3.times do |i|
          FactoryBot.create(:tweet, user: user, content: "Lorem ipsum #{i}")
        end
        log_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      it { should have_selector("textarea") }
      it { should have_field("tweet[content]") }

      describe "follower/following counts" do
        let(:other_user) { FactoryBot.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0", href: following_user_path(user)) }
        it { should have_link("1", href: followers_user_path(user)) }
      end
    end
  end
end
