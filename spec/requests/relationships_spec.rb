# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Relationships", type: :request do
  describe "POST /create" do
    context "without login" do
      before { post relationship_path }
      it { expect(response).to redirect_to(login_path) }
    end
  end

  describe "DELETE /destroy" do
    context "without login" do
      before { delete relationship_path }
      it { expect(response).to redirect_to(login_path) }
    end
  end
end
