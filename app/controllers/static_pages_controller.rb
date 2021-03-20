# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.includes(:user).paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
