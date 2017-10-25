# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe "#index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "#show" do
    it "has a 200 status code" do
      get :show, params: { id: user.slug }
      expect(response.status).to eq(200)
    end
  end

  describe "#new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    before { FactoryBot.create(:user1) }

    it "create new user" do
      post :create, params: { user: FactoryBot.attributes_for(:user) }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(assigns(:user))
    end

    it "doesn't create new user" do
      post :create, params: { user: FactoryBot.attributes_for(:user1) }
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  describe "#destroy" do
    context "no signed in" do
      it "doen't delete user" do
        delete :destroy, params: { id: user.slug }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(signin_path)
      end
    end

    context "signed in" do
      before { log_in user, no_capybara: true }
      it "deletes user" do
        expect { delete :destroy, params: { id: user.slug } }.to change(User, :count).by(-1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#update" do
    context "no signed in" do
      it "doen't update user" do
        patch :update, params: { id: user.slug }
        expect(response.status).to eq(302)
        expect(response).to redirect_to(signin_path)
      end
    end

    context "signed in" do
      let(:updated_user) { FactoryBot.attributes_for(:user) }
      before { log_in user, no_capybara: true }
      it "updates user" do
        patch :update, params: { id: user.slug, user: updated_user }
        expect(response.status).to eq(302)
        expect(user.reload.name).to eq(updated_user[:name])
        expect(user.reload.email).to eq(updated_user[:email])
      end
    end
  end
end
