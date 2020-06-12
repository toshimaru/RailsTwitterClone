# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "#index" do
    it "has a 200 status code" do
      get users_path
      expect(response.status).to eq(200)
    end
  end

  describe "#show" do
    it "has a 200 status code" do
      get user_path(user.slug)
      expect(response.status).to eq(200)
    end
  end

  describe "#new" do
    it "has a 200 status code" do
      get new_user_path
      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    it "creates new user" do
      post users_path, params: { user: FactoryBot.attributes_for(:user) }
      expect(response.status).to eq(302)
    end

    describe "User already exists" do
      it "doesn't create new user" do
        post users_path, params: { user: FactoryBot.attributes_for(:user, email: user.email) }
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#destroy" do
    context "no log in" do
      it "doen't delete user" do
        delete user_path(user.slug)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(login_path)
      end
    end

    context "log in" do
      before { log_in user, no_capybara: true }
      it "deletes user" do
        expect { delete user_path(user.slug) }.to change(User, :count).by(-1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#update" do
    context "no log in" do
      it "doen't update user" do
        patch user_path(user.slug)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(login_path)
      end
    end

    context "log in" do
      let(:updated_user) { FactoryBot.attributes_for(:user) }
      before { log_in user, no_capybara: true }
      it "updates user" do
        patch user_path(user.slug), params: { user: updated_user }
        expect(response.status).to eq(302)
        expect(user.reload.name).to eq(updated_user[:name])
        expect(user.reload.email).to eq(updated_user[:email])
      end
    end
  end
end
