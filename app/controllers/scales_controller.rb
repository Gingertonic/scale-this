class ScalesController < ApplicationController
  def index
    @scales = Scale.alphabetical
  end

  def show
    # raise params.inspect
    @scale = Scale.find_by(name: params[:scale_slug])
    @midi_notes = @scale.midi_generator(params[:root_note].to_i, 1)
    @notes = @scale.see_notes(params[:root_note].to_i, 1)
  end
end
