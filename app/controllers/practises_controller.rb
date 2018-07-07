class PractisesController < ApplicationController
  def create
    practise = current_user.practises.find_or_create_by(practise_params)
    practise.experience += 1
    practise.save
    redirect_to practice_room_path(current_user.slugify)
  end

  private
  def practise_params
    params.require(:practise).permit(:scale_id)
  end
end
