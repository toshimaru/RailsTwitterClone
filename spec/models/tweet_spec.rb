# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tweet, type: :model do
  fixtures :users

  let(:user) { users(:fixture_user_1) }

  subject(:tweet) { user.tweets.build(content: "Lorem ipsum") }

  describe "attributes" do
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:user_id) }
  end

  describe "associations" do
    it { is_expected.to respond_to(:user) }
    it { expect(tweet.user).to eq(user) }
    it { is_expected.to respond_to(:image) }
  end

  describe "validations" do
    it { is_expected.to be_valid }

    describe "when user_id is not present" do
      before { tweet.user_id = nil }
      it { is_expected.to be_invalid }
    end

    describe "with blank content" do
      before { tweet.content = " " }
      it { is_expected.to be_invalid }
    end

    describe "with content that is too long" do
      before { tweet.content = "a" * 141 }
      it { is_expected.to be_invalid }
    end

    describe "with invalid image" do
      let(:image) { fixture_file_upload(file_fixture("empty.txt")) }
      before { tweet.image.attach(image) }
      it { is_expected.to be_invalid }
    end
  end
end
