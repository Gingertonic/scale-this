class PractisesController < ApplicationController
  def create
    @scale = Scale.find(practise_params[:scale_id])
    @musician = Musician.find(practise_params[:musician_id])
    @musician.i_just_practised(@scale)
    render json: @musician
  end

  private
  def practise_params
    params.require(:practise).permit(:scale_id, :musician_id)
  end
end
