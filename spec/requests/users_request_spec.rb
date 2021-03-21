# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  fixtures :users
  let(:user) { users(:fixture_user_1) }

  describe "#index" do
    it "has a 200 status code" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "#show" do
    it "has a 200 status code" do
      get user_path(user.slug)
      expect(response).to have_http_status(200)
    end
  end

  describe "#new" do
    it "has a 200 status code" do
      get new_user_path
      expect(response).to have_http_status(200)
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
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#destroy" do
    context "no login" do
      it "doen't delete user" do
        delete user_path(user.slug)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(login_path)
      end
    end

    context "login" do
      before {
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      }
      it "deletes user" do
        expect { delete user_path(user.slug) }.to change(User, :count).by(-1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context "login as another user" do
      let(:another_user) { users(:fixture_user_2) }
      before {
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      }
      it "redirects to root" do
        delete user_path(another_user.slug)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#update" do
    context "no login" do
      it "doen't update user" do
        patch user_path(user.slug)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(login_path)
      end
    end

    context "login" do
      let(:update_param) { FactoryBot.attributes_for(:user) }
      before {
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      }
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
      before {
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      }
      it "redirects to root" do
        patch user_path(another_user.slug), params: { user: update_param }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
