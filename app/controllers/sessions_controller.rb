class SessionsController < ApplicationController
  def new
  end

  def create
    if request.env
      user = Musician.from_omniauth(auth)
      session[:user_id] = user.id
    else
      user = Musician.find_by(email: params[:email])
      (session[:user_id] = user.id) if (user && user.authenticate(params[:password]))
    end
    redirect_to scales_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private
  def auth
    request.env['omniauth.auth']
  end

end
