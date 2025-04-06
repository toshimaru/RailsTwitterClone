# frozen_string_literal: true

module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    # Guard against session replay attacks.
    session[:session_token] = user.session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= find_and_verify_user(user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_path, flash: { danger: "Please sign in." }
    end
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  private
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end

    def find_and_verify_user(user_id)
      user = User.find_by(id: user_id)
      return if user.nil?
      return if session[:session_token] != user.session_token

      user
    end
end
