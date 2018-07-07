class ApplicationController < ActionController::Base

  private
  def logged_in?
    redirect_to root_path if !session[:user_id]
  end

end
