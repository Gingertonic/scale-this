class MusiciansController < ApplicationController
  def new
    @user = Musician.new
  end

  def create
    user = Musician.create(musician_params)
    session[:user_id] = user.id
    redirect_to scales_path
  end

  def show
    @user = Musician.find_by_slug(params[:musician_slug])
    @practise_log = @user.practise_log
  end


  private
  def musician_params
    params.require(:musician).permit(:name, :email, :password, :password_confirmation)
  end
end
