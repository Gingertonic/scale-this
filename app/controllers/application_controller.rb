class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def current_username
    @slug = current_user.slugify
    render plain: @slug
  end

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

  def current_user
    (@current_user ||= Musician.find(session[:user_id])) if session[:user_id]
  end

  helper_method :current_user

end
