# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user,       only: [:show, :edit, :update, :destroy, :following, :followers]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @tweet = current_user.tweets.build if logged_in?
    @tweets = @user.tweets.with_attached_image.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome to Twitter Clone!"
      redirect_to @user
    else
      render :new
    end
  end

  # TODO: Dont't include ID in the URL
  def update
    if @user.update(user_params)
      flash[:success] = "Profile was successfully updated."
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  private
    def set_user
      @user = User.find_by!(slug: params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :slug)
    end

    def correct_user
      unless current_user?(@user)
        redirect_to(root_path)
      end
    end
end
