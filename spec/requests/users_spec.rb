# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "GET /index" do
    it "has a 200 status code" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "has a 200 status code" do
      get user_path(user.slug)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    it "has a 200 status code" do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do
    it "creates new user" do
      user_attributes = FactoryBot.attributes_for(:user)
      post users_path, params: { user: user_attributes }
      expect(response).to redirect_to(user_path(user_attributes[:slug]))
    end

    describe "User already exists" do
      it "doesn't create new user" do
        post users_path, params: { user: FactoryBot.attributes_for(:user, email: user.email) }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE /destroy" do
    context "no login" do
      it "doen't delete user" do
        delete user_path(user.slug)
        expect(response).to redirect_to(login_path)
      end
    end

    context "login" do
      before { log_in_as(user) }
      it "deletes user" do
        expect { delete user_path(user.slug) }.to change(User, :count).by(-1)
        expect(response).to redirect_to(root_path)
      end
    end

    context "login as another user" do
      let(:another_user) { users(:fixture_user_2) }
      before { log_in_as(user) }
      it "redirects to root" do
        delete user_path(another_user.slug)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PATCH /update" do
    context "no login" do
      it "doen't update user" do
        patch user_path(user.slug)
        expect(response).to redirect_to(login_path)
      end
    end

    context "login" do
      let(:update_param) { FactoryBot.attributes_for(:user) }
      before { log_in_as(user) }
      it "updates user" do
        patch user_path(user.slug), params: { user: update_param }
        user.reload
        expect(response).to redirect_to(user_path(user.slug))
        expect(user.name).to eq(update_param[:name])
        expect(user.email).to eq(update_param[:email])
      end
    end

    context "login as another user" do
      let(:update_param) { FactoryBot.attributes_for(:user) }
      let(:another_user) { users(:fixture_user_2) }
      before { log_in_as(user) }
      it "redirects to root" do
        patch user_path(another_user.slug), params: { user: update_param }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
