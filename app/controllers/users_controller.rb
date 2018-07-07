class UsersController < ApplicationController
  def show
    @user = Musician.find_by_slug(params[:user_slug])
  end
end
