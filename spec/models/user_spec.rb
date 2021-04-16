# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  fixtures :users

  subject(:user) { FactoryBot.build(:user) }

  describe "attributes" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:slug) }
    it { is_expected.to respond_to(:password_digest) }
    it { is_expected.to respond_to(:remember_digest) }
    it { is_expected.to respond_to(:remember_token) }
  end

  describe "methods" do
    it { is_expected.to respond_to(:password) }
    it { is_expected.to respond_to(:password_confirmation) }
  end

  describe "validations" do
    it { is_expected.to be_valid }

    describe "when name is not present" do
      before { user.name = " " }
      it { is_expected.to be_invalid }
    end

    describe "when name is too long" do
      before { user.name = "a" * 51 }
      it { is_expected.to be_invalid }
    end

    describe "when email format is invalid" do
      it "becomes invalid" do
        invalid_addresses = %W[user@foo,bar user.foo user@foo. too.long.email@address.com-#{"a" * 250}]
        invalid_addresses.each do |address|
          user.email = address
          is_expected.to be_invalid
        end
      end
    end

    describe "when email format is valid" do
      it "becomes valid" do
        addresses = %w[user@foo.bar a+b@a.com 1...2@a.b.c]
        addresses.each do |address|
          user.email = address
          is_expected.to be_valid
        end
      end
    end

    describe "when email address is already taken" do
      before do
        user_with_same_email = user.dup
        user_with_same_email.email = user.email.upcase
        user_with_same_email.save
      end

      it { is_expected.to be_invalid }
    end

    describe "when password doesn't match confirmation" do
      before { user.password_confirmation = "aaa" }
      it { is_expected.to be_invalid }
    end

    describe "with a password that's too short" do
      before { user.password = "a" * 3 }
      it { is_expected.to be_invalid }
    end
  end

  describe "associations" do
    subject(:user) { users(:fixture_user_1) }
    let(:other_user) { users(:fixture_user_2) }

    describe ".followers" do
      before { FactoryBot.create(:relationship, follower: user, followed: other_user) }
      it { expect(other_user.followers).to include(user) }
    end

    describe ".following" do
      before { FactoryBot.create(:relationship, follower: user, followed: other_user) }
      it { expect(user.following).to include(other_user) }
    end

    describe ".tweets" do
      let!(:older_tweet) { FactoryBot.create(:tweet, user: user, created_at: 1.day.ago) }
      let!(:newer_tweet) { FactoryBot.create(:tweet, user: user, created_at: 1.hour.ago) }

      it "has the right tweets in the right order" do
        expect(user.tweets).to eq [newer_tweet, older_tweet]
      end

      it "destroys associated tweets" do
        user.destroy!
        expect(user.tweets).to eq []
      end
    end
  end

  describe "#authenticate" do
    subject { user.authenticate(password) }

    describe "with valid password" do
      let(:password) { user.password }
      it { is_expected.to be user }
    end

    describe "with invalid password" do
      let(:password) { "invalid password" }
      it { is_expected.to be false }
    end
  end

  describe "#authenticated?" do
    subject { user.authenticated?(remember_token) }

    describe "remember_token is nil" do
      let(:remember_token) { nil }
      it { is_expected.to be false }
    end

    describe "remember_token is empty string" do
      let(:remember_token) { "" }
      it { is_expected.to be false }
    end

    describe "remeber_toke is valid" do
      let(:remember_token) { described_class.new_token }
      before { user.remember_digest = described_class.digest(remember_token) }
      it { is_expected.to be true }
    end
  end

  describe "#follow" do
    subject { user.follow(follow_user) }

    describe "user follow other user" do
      let(:follow_user) { users(:fixture_user_2) }
      it { is_expected.to eq [follow_user] }
    end

    describe "user can't follow other user" do
      let(:follow_user) { user }
      it { is_expected.to be_nil }
    end
  end

  describe "#unfollow" do
    let(:user) { users(:fixture_user_1) }
    let(:other_user) { users(:fixture_user_2) }
    before { FactoryBot.create(:relationship, follower: user, followed: other_user) }
    it { expect { user.unfollow(other_user) }.to change(user.following, :count).by(-1) }
  end

  describe "#following?" do
    subject { user.following?(follow_user) }

    let(:user) { users(:fixture_user_1) }
    let(:other_user) { users(:fixture_user_2) }
    before { FactoryBot.create(:relationship, follower: user, followed: other_user) }

    describe "user following other user" do
      let(:follow_user) { other_user }
      it { is_expected.to be true }
    end

    describe "user following other user" do
      let(:follow_user) { user }
      it { is_expected.to be false }
    end
  end

  describe "#feed" do
    subject { user.feed }

    let(:user) { users(:fixture_user_1) }
    let(:followed_user) { users(:fixture_user_2) }
    let(:unfollowed_tweet) { FactoryBot.create(:tweet) }

    before do
      FactoryBot.create(:relationship, follower: user, followed: followed_user)
      FactoryBot.create_list(:tweet, 3, user: followed_user, content: Faker::Quote.famous_last_words)
    end

    it "includes following user's tweets" do
      is_expected.to include(*followed_user.tweets)
      is_expected.not_to include(unfollowed_tweet)
    end
  end
end
