# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/users", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }
  let(:another_user) { users(:fixture_user_2) }

  describe "GET /index" do
    before { get users_path }
    it { expect(response).to be_ok }
  end

  describe "GET /show" do
    before { get user_path(user.slug) }
    it { expect(response).to be_ok }
  end

  describe "GET /new" do
    before { get signup_path }
    it { expect(response).to be_ok }
  end

  describe "POST /create" do
    it "creates a new user" do
      user_attributes = FactoryBot.attributes_for(:user)
      post users_path, params: { user: user_attributes }
      expect(response).to redirect_to(user_path(user_attributes[:slug]))
    end

    describe "User already exists" do
      it "doesn't create a new user" do
        post users_path, params: { user: FactoryBot.attributes_for(:user, email: user.email) }
        expect(response).to be_ok
      end
    end
  end

  describe "DELETE /destroy" do
    context "without login" do
      it "doen't delete a user" do
        delete user_path(user.slug)
        expect(response).to redirect_to(login_path)
      end
    end

    context "login" do
      before { log_in_as(user) }
      it "deletes a user" do
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

  describe "GET /edit" do
    context "login" do
      before { log_in_as(user) }

      describe "showing my edit page" do
        before { get edit_user_path(user) }
        it { expect(response).to be_ok }
      end

      describe "showing another user's edit page" do
        before { get edit_user_path(another_user) }
        it { expect(response).to redirect_to(root_path) }
      end
    end

    context "without login" do
      before { get edit_user_path(user) }
      it { expect(response).to redirect_to(login_path) }
    end
  end

  describe "PATCH /update" do
    context "without login" do
      before { patch user_path(user) }
      it { expect(response).to redirect_to(login_path) }
    end

    context "login" do
      let(:update_param) { FactoryBot.attributes_for(:user) }
      before { log_in_as(user) }

      describe "updating user" do
        before {
          patch user_path(user), params: { user: update_param }
          user.reload
        }
        it "updates a user" do
          expect(response).to redirect_to(user_path(user))
          expect(user.name).to eq(update_param[:name])
          expect(user.email).to eq(update_param[:email])
        end
      end

      describe "trying to update another user" do
        before { patch user_path(another_user), params: { user: update_param } }
        it { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
