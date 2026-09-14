# frozen_string_literal: true

require "rails_helper"

RSpec.describe Tweet, type: :model do
  subject(:tweet) { FactoryBot.build(:tweet) }

  describe "attributes" do
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:user_id) }
  end

  describe "associations" do
    it { is_expected.to respond_to(:user) }
    it { expect(tweet.user).to be_a(User) }
    it { is_expected.to respond_to(:image) }
  end

  describe "validations" do
    subject(:tweet) { FactoryBot.create(:tweet) }

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

  describe "#display_image" do
    let(:tweet) { FactoryBot.create(:tweet) }
    let(:image) { fixture_file_upload(file_fixture("image.png"), "image/png") }

    before { tweet.image.attach(image) }

    it "processes a resized image variant" do
      variant = tweet.display_image.processed

      expect(variant.download).to be_present
      expect(variant.download.bytesize).to be > 0
    end
  end
end
