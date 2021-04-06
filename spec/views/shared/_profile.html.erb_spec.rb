# frozen_string_literal: true

require "rails_helper"

RSpec.describe "shared/_profile", type: :view do
  fixtures :users

  before do
    @user = assign(:user, users(:fixture_user_1))
  end

  context "login" do
    before do
      @other_user = users(:fixture_user_2)
      allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(@other_user)
    end

    it "renders user follow form" do
      render

      assert_select "#follow_form" do
        assert_select "form[action=?][method=?]", relationship_path, "post" do
          assert_select "input[name=?][value=?]", "relationship[followed_id]", @user.id.to_s
          assert_select "input[type=submit][value=?]", "Follow"
        end
      end
    end
  end

  context "without login" do
    it "renders attributes" do
      render

      assert_select ".profile" do
        assert_select "div", @user.name
        assert_select "div", @user.email
        assert_select "img.gravatar[alt=?]", @user.name
      end
    end
  end
end
