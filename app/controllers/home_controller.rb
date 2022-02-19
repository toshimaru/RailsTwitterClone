# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :logged_in_user

  def index
    @tweets = current_user.feed.includes(:user).with_attached_image.paginate(page: params[:page])
  end
end
