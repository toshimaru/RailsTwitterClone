# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if logged_in?
      @tweets = current_user.feed.includes(:user).with_attached_image.paginate(page: params[:page])
    end
  end
end
