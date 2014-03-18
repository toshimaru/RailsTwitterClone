require 'spec_helper'

describe "UserPages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "/" do
    before { visit root_path }
    it { should have_content('Welcome to Twitter Clone') }
    it { should have_link('Sign in') }
    it { should have_link('Sign up') }
  end

  describe "/user/:id" do
    before { visit user_path(user) }
    it { should have_content(user.name) }
  end

  describe "/signup" do
    before { visit signup_path }
    let(:submit) { "Sign up" }
    it { should have_content('Sign up') }

    context "with valid information" do
      before do
        fill_in "Name",                  with: "Example User"
        fill_in "Email",                 with: "user@example.com"
        fill_in "Password",              with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_title(user.name) }
      end
    end

    context "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

  end

end
