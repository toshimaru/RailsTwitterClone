# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  fixtures :users, :tweets

  subject(:user) do
    User.new(name: "toshimaru", email: "mail@example.com", slug: "toshimaru",
             password: "my password", password_confirmation: "my password")
  end

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:slug) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:feed) }
  it { should respond_to(:active_relationships) }
  it { should respond_to(:following) }
  it { should respond_to(:passive_relationships) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow) }
  it { should respond_to(:remember_token) }

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
      it "should be invalid" do
        addresses = %w[user@foo,bar user.foo user@foo.]
        addresses << "too.long.email@address.com-#{"a" * 250}"
        addresses.each do |address|
          user.email = address
          expect(user).to be_invalid
        end
      end
    end

    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.bar a+b@a.com toshi...1@a.b.c]
        addresses.each do |address|
          user.email = address
          expect(user).to be_valid
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
    describe ".followers" do
      let(:user) { users(:fixture_user_1) }
      let(:other_user) { users(:fixture_user_2) }
      before { user.follow!(other_user) }
      it { expect(other_user.followers).to include(user) }
    end

    describe ".associations" do
      before { user.save }

      let!(:older_tweet) { FactoryBot.create(:tweet, user: user, created_at: 1.day.ago) }
      let!(:newer_tweet) { FactoryBot.create(:tweet, user: user, created_at: 1.hour.ago) }

      it "should have the right tweets in the right order" do
        expect(user.tweets).to eq [newer_tweet, older_tweet]
      end

      it "should destroy associated tweets" do
        tweets = user.tweets
        user.destroy!
        tweets.each do |tweet|
          expect(Tweet.find_by(id: tweet.id)).to be_nil
        end
      end

      describe "status" do
        let(:unfollowed_post) { tweets(:tweet) }
        let(:followed_user) { users(:fixture_user_2) }

        before do
          user.follow!(followed_user)
          3.times { followed_user.tweets.create!(content: Faker::Quote.famous_last_words) }
        end

        it "includes following user's tweets" do
          expect(user.feed).to include(newer_tweet, older_tweet, *followed_user.tweets)
          expect(user.feed).not_to include(unfollowed_post)
        end
      end
    end
  end

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by(email: user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      it { expect(user_for_invalid_password).to be false }
    end
  end


  describe "#following?" do
    let(:user) { users(:fixture_user_1) }
    let(:other_user) { users(:fixture_user_2) }
    before { user.follow!(other_user) }
    it { is_expected.to be_following(other_user) }
  end

  describe "#authenticated?" do
    it "should return false for a user with nil digest" do
      expect(user.authenticated?(nil)).to be false
      expect(user.authenticated?("")).to be false
    end
  end
end
