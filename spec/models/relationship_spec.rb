# frozen_string_literal: true

require "rails_helper"

RSpec.describe Relationship, type: :model do
  let(:follower) { FactoryBot.create(:user) }
  let(:followed) { FactoryBot.create(:user) }
  subject(:relationship) { follower.relationships.build(followed_id: followed.id) }

  it { should be_valid }

  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }

    specify {
      expect(relationship.follower).to eq(follower)
      expect(relationship.followed).to eq(followed)
    }
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { should_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { should_not be_valid }
  end
end
