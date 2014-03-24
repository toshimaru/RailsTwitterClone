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
      it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end

    context 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe "visit root page" do
        before { visit root_path }
        it { should have_content('Welcome to Twitter Clone') }
        it { should have_link('Sign in') }
        it { should have_link('Sign up') }
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_content('Update your profile')
          end
        end
      end

      describe "visiting the edit page" do
        before { visit edit_user_path(user) }
        it { should have_content('Sign in') }
      end

      describe "in the Users Controller" do
        describe "visit the following page" do
          before { visit following_user_path(user) }
          it { should have_title('Following') }
        end
        describe "visit the followers page" do
          before { visit followers_user_path(user) }
          it { should have_title('Followers') }
        end
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Users') }
        end
      end

      # describe "in the Relationships controller" do
      #   describe "submitting to the create action" do
      #     before { post relationships_path }
      #     specify { expect(response).to redirect_to(signin_path) }
      #   end

      #   describe "submitting to the destroy action" do
      #     before { delete relationship_path(1) }
      #     specify { expect(response).to redirect_to(signin_path) }
      #   end
      # end

      # describe "submitting to the update action" do
      #   before { patch user_path(user) } # undifined method `patch` because capybara doesn't support PUT/PATCH
      #   specify { expect(response).to redirect_to(signin_path) }
      # end

      # describe "in the Microposts controller" do
      #   describe "submitting to the create action" do
      #     before { post microposts_path }
      #     specify { expect(response).to redirect_to(signin_path) }
      #   end
      #   describe "" do
      #     before { delete microposts_path }
      #   end
      # end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "Visit wrong_user's edit page" do
        before { visit edit_user_path(wrong_user) }

        it { should_not have_content('Update your profile') }
        it { should have_content('Sign in') }
      end
    end

  end

end
