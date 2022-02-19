# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    redirect_to home_path if logged_in?
  end
end
