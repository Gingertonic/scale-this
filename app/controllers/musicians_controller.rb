class MusiciansController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

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
    redirect_to login_path, alert: "That's not your practise room!" if not_your_room(@user)
    @practise_log = @user.practise_log
  end

  def rankings
    params[:by]
    @musicians = Musician.order_by(params[:by])
  end


  private
  def musician_params
    params.require(:musician).permit(:name, :email, :password, :password_confirmation)
  end

  def not_your_room(user)
    current_user != user
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
