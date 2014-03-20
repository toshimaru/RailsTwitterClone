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

  describe "edit" do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
      it { should have_link('Delete my account', href: user_path(user)) }
    end

    context "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('too short') }
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

      it { should have_title(new_name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Setting',     href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
  end

end
