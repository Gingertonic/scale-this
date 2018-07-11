class PractisesController < ApplicationController
  def create
    current_user.i_just_practised(practise_params)
    redirect_to practice_room_path(current_user.slugify)
  end

  private
  def practise_params
    params.require(:practise).permit(:scale_id)
  end
end
