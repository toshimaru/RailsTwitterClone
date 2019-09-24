# frozen_string_literal: true

require "rails_helper"

RSpec.describe Relationship, type: :model do
  fixtures :users

  let(:follower) { users(:fixture_user_1) }
  let(:followed) { users(:fixture_user_2) }

  subject(:relationship) { follower.active_relationships.build(followed_id: followed.id) }

  it { should be_valid }

  describe "follower methods" do
    it "has correct relationships" do
      expect(relationship.follower).to eq(follower)
      expect(relationship.followed).to eq(followed)
    end
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should be_invalid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should be_invalid }
  end
end
