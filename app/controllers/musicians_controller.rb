class MusiciansController < ApplicationController

  def new
    redirect_to root_path if logged_in?
    @user = Musician.new
  end

  def create
    redirect_to root_path if logged_in?
    @user = Musician.new(musician_params)
    validate(@user)
  end

  def show
    @user = Musician.find_by_slug(params[:musician_slug])
    render json: @user, serializer: MusicianPracticeDataSerializer
  end

  def rankings
    @musicians = Musician.order_by(params[:by])
    render json: @musicians, each_serializer: MusicianRankSerializer
  end

  def practise_log
    musician = Musician.find(params[:id])
    @practise_log = musician.practise_log
    render json: @practise_log
  end


  private
  def musician_params
    params.require(:musician).permit(:name, :email, :password, :password_confirmation)
  end


  def validate(user)
    if user.save
      login(user)
      redirect_to scales_path
    else
      render :new
    end
  end


end
