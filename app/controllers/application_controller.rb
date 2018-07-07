class ApplicationController < ActionController::Base

  private
  def logged_in?
    redirect_to root_path if !session[:user_id]
  end

  def current_user
    (@current_user ||= Musician.find(session[:user_id])) if session[:user_id]
  end
  helper_method :current_user

end
