require 'rails_helper'

describe RelationshipsController do
  describe "in the Relationships controller" do
    describe "submitting to the create action" do
      before { post :create }
      it { expect(response).to redirect_to(signin_path) }
    end

    describe "submitting to the destroy action" do
      before { delete :destroy, id: 1 }
      it { expect(response).to redirect_to(signin_path) }
    end
  end
end
