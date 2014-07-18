require 'rails_helper'

describe "Static Pages" do

  subject { page }

  describe "Home Page" do

    describe "for signed in users" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        FactoryGirl.create(:tweet, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:tweet, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      it { should have_selector('textarea') }
      it { should have_field('tweet[content]') }

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link('0', href: following_user_path(user)) }
        it { should have_link('1', href: followers_user_path(user)) }
      end

    end
  end

end
