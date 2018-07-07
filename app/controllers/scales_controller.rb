class ScalesController < ApplicationController
  def index
    @scales = Scale.alphabetical
  end

  def show
    @scale = Scale.find_by(name: params[:scale_slug])
    @midi_notes = @scale.midi_generator(params[:root_note].to_i, 1)
    @notes = @scale.see_notes(params[:root_note].to_i, 1)
    @roots = Note.all
  end

  def change_root
    redirect_to scale_path({scale_slug: params[:scale_slug], root_note: params[:root]})
  end

end
