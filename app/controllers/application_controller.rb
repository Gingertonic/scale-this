class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_username
    if current_user
      @slug = current_user.slugify
      render plain: @slug
    end
  end

  def current_user
    (@current_user ||= Musician.find(session[:user_id])) if session[:user_id]
  end

  def check_session
    render json: session[:user_id]
  end

  helper_method :current_user

  private

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !!session[:user_id]
  end

  def require_login
    redirect_to login_path, alert: "Please login first!" unless logged_in?
  end



end
