require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "GET /" do
    before { visit root_path }
    it { have_content('Welcome to Twitter Clone') }
  end
end
