# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Relationships", type: :request do
  describe "in the Relationships controller" do
    describe "submitting to the create action" do
      before { post relationship_path }
      it { expect(response).to redirect_to(login_path) }
    end

    describe "submitting to the destroy action" do
      before { delete relationship_path }
      it { expect(response).to redirect_to(login_path) }
    end
  end
end
