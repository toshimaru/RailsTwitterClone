# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @feed_items = current_user.feed.includes(:user).paginate(page: params[:page])
    end
  end

  def about
  end
end
