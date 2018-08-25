class MusiciansController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    redirect_to root_path if logged_in?
    @user = Musician.new
  end

  # def create
  #   redirect_to root_path if logged_in?
  #   @user = Musician.new(musician_params)
  #   validate(@user)
  # end

  def show
    redirect_to login_path, alert: "That's not your practise room!" if not_your_room(@user)
    @user = Musician.find_by_slug(params[:musician_slug])
    respond_to do |f|
      f.json { render json: @user }
    end
    # @practise_log = @user.practise_log - MOVE TO JS CLASS OBJECT
  end

  def rankings
    redirect_to musician_rankings_path("name") unless valid_ranking?(params[:by])
    @musicians = Musician.order_by(params[:by])
    render json: @musicians
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

  def valid_ranking?(param)
    param == "name" || param == "total-practises" || param == "last-practised"
  end

end
