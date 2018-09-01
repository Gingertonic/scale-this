class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:new, :create]
  def new
    redirect_to root_path if logged_in?
  end

  def create
    redirect_to root_path if logged_in?
    if request.env['omniauth.auth']
      user = Musician.from_omniauth(auth)
      login(user)
      redirect_to scales_path
    else
      authenticate_local_login(params)
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private
  def auth
    request.env['omniauth.auth']
  end

  def logout
    session.clear
  end

  def authenticate_local_login(params)
    user = Musician.find_by_email(params[:email])
    if !user
      redirect_to new_musician_path, alert: "We can't find an account with this email!"
    elsif !user.authenticate(params[:password]) && user.provider == 'facebook'
      redirect_to login_path, alert: "It looks like you registered via Facebook, please click 'continue with Facebook' to login."
    elsif !user.authenticate(params[:password])
      redirect_to login_path, alert: "Oops, wrong password!"
    elsif user && user.authenticate(params[:password])
      login(user)
      redirect_to scales_path
    end
  end

end
