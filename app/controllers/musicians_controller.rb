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
    @practise_log = @user.practise_log
    # @today = @user.practised("today")
    # @yesterday = @user.practised("yesterday")
    # @this_week = @user.practised("this week")
    # @this_month = @user.practised("this month")
    # @ages_ago = @user.practised("ages ago")
  end

  private
  def musician_params
    params.require(:musician).permit(:name, :email, :password, :password_confirmation)
  end
end
