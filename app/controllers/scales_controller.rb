class ScalesController < ApplicationController
  before_action :logged_in?

  def index
    @scales = Scale.alphabetical
  end

  def show
    if params[:root_note]
      root_note = params[:root_note].to_i
    else
      root_note = 60
    end
    @scale = Scale.find_by(name: params[:scale_slug])
    @midi_notes = @scale.midi_generator(root_note, 1)
    @notes = @scale.see_notes(root_note, 1)
    @roots = Note.all
    @practise = Practise.new(scale: @scale)
  end

  def change_root
    scale = Scale.find_by(name: params[:scale_slug])
    redirect_to show_scale_path({scale_slug: scale.name, root_note: params[:root]})
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
    # byebug
    @scale = Scale.find_by(name: params[:scale_slug])
    # @scale = Scale.find(params[:id])
    @note_selection = Note.limit(12)
    @pattern = @scale.midi_generator(55, 1)
  end

  def update
    # byebug
    scale = Scale.find_by(params[:id])
    scale.custom_update(scale, scale_params)
    redirect_to show_scale_path({scale_slug: scale.name, root_note: 60})
  end

  def destroy
    Scale.find(params[:id]).destroy
    redirect_to scales_path
  end

  private
  def scale_params
    params.require(:scale).permit(:name, :scale_type, :origin, :melody_rules, :pattern => [])
  end
end
