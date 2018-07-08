class ScalesController < ApplicationController
  before_action :logged_in?

  def index
    @scales = Scale.alphabetical
  end

  def show
    @scale = Scale.find_by(name: params[:scale_slug])
    @midi_notes = @scale.midi_generator(params[:root_note].to_i, 1)
    @notes = @scale.see_notes(params[:root_note].to_i, 1)
    @roots = Note.all
    @practise = Practise.new(scale: @scale)
  end

  def change_root
    redirect_to show_scale_path({scale_slug: params[:scale_slug], root_note: params[:root]})
  end

  def new
    @scale = Scale.new
    @note_selection = Note.limit(12)
    @pattern = []
  end

  def create
    # raise params.inspect
    scale = Scale.create_custom(scale_params)
    redirect_to show_scale_path({scale_slug: scale.name, root_note: 60})
  end

  def edit
    @scale = Scale.find_by(name: params[:scale_slug])
    @note_selection = Note.limit(12)
    @pattern = @scale.midi_generator(55, 1)
  end

  def update
    Scale.find_by(name: params[:scale_slug]).update(scale_params)
  end

  private
  def scale_params
    params.require(:scale).permit(:name, :scale_type, :origin, :melody_rules, :pattern => [])
  end
end
