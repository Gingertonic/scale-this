class PractisesController < ApplicationController
  def create
    @scale = Scale.find(practise_params[:scale_id])
    @musician = Musician.find(practise_params[:musician_id])
    # byebug
    @musician.i_just_practised(@scale)
    respond_to do |f|
      f.json { render json: @musician }
    end
  end

  private
  def practise_params
    params.require(:practise).permit(:scale_id, :musician_id)
  end
end
