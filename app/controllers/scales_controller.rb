class ScalesController < ApplicationController
  before_action :logged_in?

  def index
    @scales = Scale.alphabetical
  end

  def show
    if params[:root_note]
      root_note = Note.find_by(solfege: params[:root_note]).midi_value
    else
      root_note = 60
    end
    @scale = Scale.find_by(name: params[:scale_slug])
    redirect_to scales_path, alert: "Hey, that's private!" if @scale.private && @scale.created_by != current_user.id
    @midi_notes = @scale.midi_generator(root_note, 1)
    @notes = @scale.see_notes(root_note, 1)
    @roots = Note.select{|n| n.reference}
    @practise = Practise.new(scale: @scale)
  end

  def change_root
    scale = Scale.find_by(name: params[:scale_slug])
    redirect_to show_scale_path({scale_slug: scale.name, root_note: params[:root]})
  end

  def new
    @scale = Scale.new
    # byebug
    @note_selection = Note.select{|n| n.reference}
    @pattern = []
  end

  def create
    scale = Scale.create_custom(scale_params)
    scale.created_by = current_user.id
    scale.save
    # byebug
    redirect_to show_scale_path({scale_slug: scale.name, root_note: "do"})
  end

  def edit
    # byebug
    @scale = Scale.find_by(name: params[:scale_slug])
    # @scale = Scale.find(params[:id])
    @note_selection = Note.select{|n| n.reference}
    @pattern = @scale.midi_generator(55, 1)
  end

  def update
    # byebug
    scale = Scale.find(params[:id])
    scale.custom_update(scale, scale_params)
    redirect_to show_scale_path({scale_slug: scale.name, root_note: "do"})
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
