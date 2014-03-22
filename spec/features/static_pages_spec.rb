require 'spec_helper'

describe "Static Pages" do

  subject { page }

  describe "Home Page" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
      FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
      sign_in user
      visit root_path
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        expect(page).to have_selector("li##{item.id}", text: item.content)
      end
    end

  end

end
