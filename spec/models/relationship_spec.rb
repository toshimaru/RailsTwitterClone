# frozen_string_literal: true

require "rails_helper"

RSpec.describe Relationship, type: :model do
  fixtures :users

  let(:follower) { users(:fixture_user_1) }
  let(:followed) { users(:fixture_user_2) }

  subject { follower.active_relationships.build(followed_id: followed.id) }

  it "has correct relationships" do
    expect(subject.follower).to eq(follower)
    expect(subject.followed).to eq(followed)
  end

  describe "validations" do
    it { is_expected.to be_valid }

    describe "when followed id is not present" do
      before { subject.followed_id = nil }
      it { is_expected.to be_invalid }
    end

    describe "when follower id is not present" do
      before { subject.follower_id = nil }
      it { is_expected.to be_invalid }
    end
  end
end
