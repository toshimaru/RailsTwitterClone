# frozen_string_literal: true

require "rails_helper"

RSpec.describe RelationshipsController, type: :controller do
  describe "in the Relationships controller" do
    describe "submitting to the create action" do
      before { post :create }
      it { expect(response).to redirect_to(signin_path) }
    end

    describe "submitting to the destroy action" do
      before { delete :destroy, params: { id: 1 } }
      it { expect(response).to redirect_to(signin_path) }
    end
  end
end
