# frozen_string_literal: true

require "rails_helper"

RSpec.describe "AccountActivations", type: :request do
  describe "GET /edit" do
    let(:user) { FactoryBot.create(:user, :inactive) }

    context "valid activation token and email" do
      before { get edit_account_activation_path(user.activation_token, email: user.email) }
      it "redirects to user_path(user)" do
        expect(flash[:success]).to eq("Account activated!")
        expect(response).to redirect_to user_path(user)
      end
    end

    context "invalid" do
      context "invalid email" do
        before { get edit_account_activation_path(user.activation_token, email: "invalid@example.com") }
        it "redirects to root" do
          expect(response).to redirect_to root_path
          expect(flash[:danger]).to eq("Invalid activation link")
        end
      end

      context "invalid token" do
        before { get edit_account_activation_path("invlalid-token", email: user.email) }
        it "redirects to root" do
          expect(response).to redirect_to root_path
          expect(flash[:danger]).to eq("Invalid activation link")
        end
      end
    end
  end
end
