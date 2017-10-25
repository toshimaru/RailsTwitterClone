# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { User.new(name: "toshi", email: "mail@test.com",
                            password: "my password", password_confirmation: "my password") }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:tweets) }
  it { should respond_to(:feed) }
  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) }

  it { should be_valid }

  describe "when name is not present" do
    before { user.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,bar user.foo user@foo.]
      addresses << "too.long.email@address.com" + "a" * 250
      addresses.each do |address|
        user.email = address
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email format is invalid" do
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

    it { should_not be_valid }
  end

  describe "when password is not present" do
    subject(:user) { User.new(name: "Example User", email: "user@example.com",
                              password: " ", password_confirmation: " ") }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "aaa" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { user.password = user.password_confirmation = "a" * 3 }
    it { should be_invalid }
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
      specify { expect(user_for_invalid_password).to be false }
    end
  end

  describe "remember token" do
    before { user.save }
    it { expect(user.remember_token).not_to be_blank }
  end

  describe "tweet associations" do
    before { user.save }
    let!(:older_tweet) do
      FactoryBot.create(:tweet, user: user, created_at: 1.day.ago)
    end
    let!(:newer_tweet) do
      FactoryBot.create(:tweet, user: user, created_at: 1.hour.ago)
    end

    it "should have the right tweets in the right order" do
      expect(user.tweets.to_a).to eq [newer_tweet, older_tweet]
    end

    it "should destroy associated tweets" do
      tweets = user.tweets.to_a
      user.destroy
      expect(tweets).not_to be_empty
      tweets.each do |m|
        expect(Tweet.where(id: m.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) {
        FactoryBot.create(:tweet, user: FactoryBot.create(:user))
      }
      let(:followed_user) { FactoryBot.create(:user) }

      before do
        user.follow!(followed_user)
        3.times { followed_user.tweets.create!(content: "Love & Peace!") }
      end

      specify do
        expect(user.feed).to include(newer_tweet)
        expect(user.feed).to include(older_tweet)
        expect(user.feed).not_to include(unfollowed_post)

        followed_user.tweets.each do |tweet|
          expect(user.feed).to include(tweet)
        end
      end
    end
  end

  describe "following" do
    let(:other_user) { FactoryBot.create(:user) }

    before do
      user.save
      user.follow!(other_user)
    end

    it { should be_following(other_user) }
    specify { expect(user.followed_users).to include(other_user) }

    describe "followed user" do
      specify { expect(other_user.followers).to include(user) }
    end
  end
end
