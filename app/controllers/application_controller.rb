class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  private
  def logged_in?
    !!session[:user_id]
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please login first!"
    end
  end

  def current_user
    (@current_user ||= Musician.find(session[:user_id])) if session[:user_id]
  end
  helper_method :current_user

end
