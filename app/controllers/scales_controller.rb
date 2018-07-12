class ScalesController < ApplicationController

  def index
    @scales = Scale.custom_index(current_user)
    @types = Scale.types
  end

  def show
    root_note = Note.get_root(params)
    @scale = Scale.find_by_slug(params[:scale_slug])
    valid_scale?(@scale)
    @midi_notes = @scale.midi_generator(root_note, 1)
    @notes = @scale.see_notes(root_note, 1)
    @roots = Note.references
    @practise = Practise.new(scale: @scale)
    @owner = Musician.find(@scale.created_by)
    @your_practise = current_user.practises.find_by(scale: @scale)
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
    @scale = Scale.find_by_slug(params[:scale_slug])
    editable_scale?(@scale)
    @note_selection = Note.select{|n| n.reference}
    @pattern = @scale.midi_generator(55, 1)
  end

  def update
    scale = Scale.find(params[:id])
    editable_scale?(scale)
    scale.custom_update(scale, scale_params)
    redirect_to show_scale_path({scale_slug: scale.slugify, root_note: "do"})
  end

  def destroy
    scale = Scale.find(params[:id]).destroy
    editable_scale?(scale)
    redirect_to scales_path
  end

  private
  def scale_params
    params.require(:scale).permit(:name, :scale_type, :origin, :melody_rules, :created_by, :private, :pattern => [])
  end

  def valid_scale?(scale)
    if !scale
      redirect_to scales_path, alert: "Hm, we can't find that scale, sorry!"
      false
    elsif scale.not_your_scale(current_user)
      redirect_to scales_path, alert: "Hey, that's private!"
      false
    else
      true
    end
  end

  def editable_scale?(scale)
    if valid_scale?(scale) && scale.created_by != current_user.id
      redirect_to show_scale_path({scale_slug: scale.slugify, root_note: "do"}), alert: "You can't edit this scale, sorry!"
    end
  end

end
