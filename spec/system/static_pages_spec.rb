# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Static Pages", type: :system do
  subject { page }

  describe "Help" do
    before { visit help_path }
    it { is_expected.to have_title "Help" }
    it { is_expected.to have_content "Help" }
  end

  describe "About" do
    before { visit about_path }
    it { is_expected.to have_title "About" }
    it { is_expected.to have_content "About" }
  end
end
