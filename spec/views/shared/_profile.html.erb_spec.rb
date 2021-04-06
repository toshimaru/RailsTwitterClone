# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shared/_profile", type: :view do
  fixtures :users

  before do
    @user = assign(:user, users(:fixture_user_1))
  end

  context "without login" do
    it "renders attributes in <p>" do
      render

      assert_select ".profile" do
        assert_select "div", @user.name
        assert_select "div", @user.email
        assert_select "img.gravatar[alt=?]", @user.name
      end
    end
  end
end
