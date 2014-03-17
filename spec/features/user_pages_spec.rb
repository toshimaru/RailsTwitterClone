require 'spec_helper'

describe "UserPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  describe "GET /" do
    before { visit root_path }
    it { should have_content('Welcome to Twitter Clone') }
    it { should have_link('Sign In') }
    it { should have_link('Sign Up') }
  end

  describe "GET /user/:id" do
    before { visit user_path(user) }
    it { should have_content(user.name) }
  end

  describe "GET /signup" do
    before { visit signup_path }

    let(:submit) { "Create User" }

    it { should have_content('Sign Up') }

    describe "with valid information" do
      before do
        fill_in "Name",                  with: "Example User"
        fill_in "Email",                 with: "user@example.com"
        fill_in "Password",              with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end
