class MusiciansController < ApplicationController
  def new
    @user = Musician.new
  end

  def create
    # raise params.inspect
    user = Musician.create(musician_params)
    session[:user_id] = user.id
    redirect_to scales_path
  end

  def show
    @user = Musician.find_by_slug(params[:musician_slug])
    @today = @user.practises.select{|p| p.status == "today"}
    @yesterday = @user.practises.select{|p| p.status == "yesterday"}
    @this_week = @user.practises.select{|p| p.status == "this week"}
    @this_month = @user.practises.select{|p| p.status == "this month"}
    @ages_ago = @user.practises.select{|p| p.status == "ages ago"}
  end

  private
  def musician_params
    params.require(:musician).permit(:name, :email, :password, :password_confirmation)
  end
end
