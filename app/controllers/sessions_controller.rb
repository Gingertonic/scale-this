class SessionsController < ApplicationController
  def new
  end

  def create
    user = Musician.find_by(email: params[:email])
    (session[:user_id] = user.id) if (user && user.authenticate(params[:password]))
    redirect_to scales_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
