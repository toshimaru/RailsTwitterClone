require 'rails_helper'

describe TweetsController do
  describe "in the Tweets controller" do

    describe "#index" do
      before { get :index}
      it { expect(response.status).to eq(200) }
    end

    describe "#create" do
      before { post :create }
      it { expect(response).to redirect_to(signin_path) }
    end

    describe "#destroy" do
      before { delete :destroy, id: 1 }
      it { expect(response).to redirect_to(signin_path) }
    end

  end
end
