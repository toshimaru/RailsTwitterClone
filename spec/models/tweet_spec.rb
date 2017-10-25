# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tweet, type: :model do
  let(:user) { FactoryBot.create(:user) }

  subject(:tweet) { user.tweets.build(content: "Lorem ipsum") }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { expect(tweet.user).to eq(user) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { tweet.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { tweet.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { tweet.content = "a" * 141 }
    it { should_not be_valid }
  end
end
