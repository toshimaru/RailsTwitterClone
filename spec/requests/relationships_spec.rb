# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Relationships", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }
  let(:another_user) { users(:fixture_user_2) }

  describe "POST /create" do
    context "login" do
      before { log_in_as(user) }

      it "creates relationship" do
        expect {
          post relationship_path, params: { relationship: { followed_id: another_user.id } }
        }.to change(Relationship, :count).by(1)
        relationship = Relationship.find_by(follower: user, followed: another_user)
        expect(relationship.follower).to eq user
        expect(relationship.followed).to eq another_user
      end
    end

    context "without login" do
      before { post relationship_path }
      it { expect(response).to redirect_to(login_path) }
    end
  end

  describe "DELETE /destroy" do
    context "login" do
      before {
        FactoryBot.create(:relationship, follower: user, followed: another_user)
        log_in_as(user)
      }

      it "destroys relationship" do
        expect {
          delete relationship_path, params: { relationship: { followed_id: another_user.id } }
        }.to change(Relationship, :count).by(-1)
        relationship = Relationship.find_by(follower: user, followed: another_user)
        expect(relationship).to be_nil
      end
    end

    context "without login" do
      before { delete relationship_path }
      it { expect(response).to redirect_to(login_path) }
    end
  end
end
