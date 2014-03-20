require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe 'authorization' do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }

    context 'with invalid information' do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting another page" do
        before { visit root_path }
        it { should_not have_selector('div.alert.alert-danger') }
      end

    end

    context "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
        it { should have_link('Sign up') }
      end
    end

    context 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe "visiting the edit page" do
        before { visit edit_user_path(user) }
        it { should have_title('Sign in') }
      end

      # describe "submitting to the update action" do
      #   before { patch user_path(user) } # undifined method `patch` because capybara doesn't support PUT/PATCH
      #   specify { expect(response).to redirect_to(signin_path) }
      # end
    end

  end

end
