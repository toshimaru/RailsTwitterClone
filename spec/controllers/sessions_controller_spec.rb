require 'rails_helper'

describe SessionsController do

  describe "#new" do
    context "GET" do
      it "has a 200 status code" do
        get :new
        expect(response.status).to eq(200)
      end
    end
  end

end
