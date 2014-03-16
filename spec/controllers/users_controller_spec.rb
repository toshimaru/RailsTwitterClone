require 'spec_helper'

describe UsersController do
  before { @user = FactoryGirl.create(:user) }

  describe "#index" do
    context "GET" do
      it "has a 200 status code" do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#show" do
    context "GET" do
      it "has a 200 status code" do
        get :show, id: @user.id
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#new" do
    context "GET" do
      it "has a 200 status code" do
        get :new
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#create" do
    context "POST" do
      it "create new user" do
        post :create, user: FactoryGirl.attributes_for(:user_having_different_email)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(assigns(:user))
      end

      it "doesn't create new user" do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response.status).to eq(200)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#destroy" do
    pending "not yet"
  end

  describe "#update" do
    pending "not yet"
  end

end
