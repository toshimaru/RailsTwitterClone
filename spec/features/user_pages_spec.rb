require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "GET /" do
    before { visit root_path }
    it { should have_content('Welcome to Twitter Clone') }
    it { should have_link('Sign In') }
    it { should have_link('Sign Up') }
  end
end
