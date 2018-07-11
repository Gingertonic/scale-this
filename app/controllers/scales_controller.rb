class ScalesController < ApplicationController
  before_action :logged_in?

  def index
    @scales = Scale.custom_index(current_user)
    @types = Scale.types
  end

  def show
    root_note = Note.get_root(params)
    @scale = Scale.find_by_slug(params[:scale_slug])
    redirect_to scales_path, alert: "Hey, that's private!" if @scale.not_your_scale(current_user)
    @midi_notes = @scale.midi_generator(root_note, 1)
    @notes = @scale.see_notes(root_note, 1)
    @roots = Note.references
    @practise = Practise.new(scale: @scale)
  end

  def change_root
    scale = Scale.find_by_slug(params[:scale_slug])
    redirect_to show_scale_path({scale_slug: scale.slugify, root_note: params[:root]})
  end

  def new
    @scale = Scale.new
    @note_selection = Note.references
    @pattern = []
  end

  def create
    scale = Scale.create_custom(current_user, scale_params)
    redirect_to show_scale_path({scale_slug: scale.slugify, root_note: "do"})
  end

  def edit
    @scale = Scale.find_by(name: params[:scale_slug])
    @note_selection = Note.select{|n| n.reference}
    @pattern = @scale.midi_generator(55, 1)
  end

  def update
    scale = Scale.find(params[:id])
    scale.custom_update(scale, scale_params)
    redirect_to show_scale_path({scale_slug: scale.slugify, root_note: "do"})
  end

  def destroy
    Scale.find(params[:id]).destroy
    redirect_to scales_path
  end

  private
  def scale_params
    params.require(:scale).permit(:name, :scale_type, :origin, :melody_rules, :created_by, :private, :pattern => [])
  end
end
