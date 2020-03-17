# frozen_string_literal: true

require "rails_helper"

RSpec.describe TweetsController, type: :request do
  describe "in the Tweets controller" do
    describe "#index" do
      before { get :index }
      it { expect(response.status).to eq(200) }
    end

    describe "#create" do
      before { post :create }
      it { expect(response).to redirect_to(login_path) }
    end

    describe "#destroy" do
      before { delete :destroy, params: { id: 1 } }
      it { expect(response).to redirect_to(login_path) }
    end
  end
end
