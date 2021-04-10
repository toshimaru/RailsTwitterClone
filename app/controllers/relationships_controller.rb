# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_followed_user

  def create
    current_user.follow(@user)
    redirect_to @user
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to @user
  end

  private
    def set_followed_user
      @user = User.find(params[:relationship][:followed_id])
    end
end
