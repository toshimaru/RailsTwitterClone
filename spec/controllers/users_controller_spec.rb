require 'spec_helper'

describe UsersController do
  before { @user = FactoryGirl.create(:user) }

  describe "#index" do
    context "GET" do
      it "has a 200 status code" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#show" do
    context "GET" do
      it "has a 200 status code" do
        get :show, id: @user.id
        expect(response).to be_success
        expect(response.status).to eq(200)
      end
    end
  end

end
