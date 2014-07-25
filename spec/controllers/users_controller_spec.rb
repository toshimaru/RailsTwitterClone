require 'rails_helper'

describe UsersController do
  before { @user = FactoryGirl.create(:user) }
  let(:user) { @user }

  describe "#index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "#show" do
    it "has a 200 status code" do
      get :show, id: user.slug
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
    before { FactoryGirl.create(:user1) }

    it "create new user" do
      post :create, user: FactoryGirl.attributes_for(:user)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(assigns(:user))
    end

    it "doesn't create new user" do
      post :create, user: FactoryGirl.attributes_for(:user1)
      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  describe "#destroy" do
    context "no signed in" do
      it "doen't delete user" do
        delete :destroy, id: user.slug
        expect(response.status).to eq(302)
        expect(response).to redirect_to(signin_path)
      end
    end

    context "signed in" do
      before { sign_in user, no_capybara: true }
      it "deletes user" do
        expect { delete :destroy, id: user.slug }.to change(User, :count).by(-1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#update" do
    context "no signed in" do
      it "doen't update user" do
        patch :update, id: user.slug #, user: FactoryGirl.attributes_for(:user)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(signin_path)
      end
    end

    context "signed in" do
      let(:updated_user) { FactoryGirl.attributes_for(:user) }
      before { sign_in user, no_capybara: true }
      it "updates user" do
        patch :update, id: user.slug, user: updated_user
        expect(response.status).to eq(302)
        expect(user.reload.name).to eq(updated_user[:name])
        expect(user.reload.email).to eq(updated_user[:email])
      end
    end
  end

end
