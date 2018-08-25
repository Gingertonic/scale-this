class ScalesController < ApplicationController

  def index
    @scales = Scale.custom_index(current_user)
    @types = Scale.types #- MOVE TO JS CLASS OBJECT
    respond_to do |f|
      f.html { render 'index' }
      f.json { render json: @scales, each_serializer: SimpleScaleSerializer }
    end
  end

  def show
    root_note = Note.get_root(params)
    @scale = Scale.find_by_slug(params[:scale_slug])
    if valid_scale?(@scale)
      respond_to do |f|
        f.html { render 'index' }
        f.json { render json: @scale }
      end
      # @midi_notes = @scale.midi_generator(root_note, 1) -  - MOVE TO JS CLASS OBJECT
      # @current_root = params[:root_note]
      # @roots = Note.references
      # @practise = Practise.new(scale: @scale)
      # @owner = Musician.find(@scale.created_by)
      # @your_practise = current_user.find_scale(@scale)
    end
  end

  # def change_root
  #   scale = Scale.find_by_slug(params[:scale_slug])
  #   go_to(scale, params[:root])
  # end

  # def new
  #   @scale = Scale.new
  #   @note_selection = Note.references
  #   @pattern = []
  # end

  # def create
  #   @scale = Scale.create_custom(current_user, scale_params)
  #   if @scale.save
  #     go_to(@scale)
  #   else
  #     @note_selection = Note.references
  #     @pattern = @scale.midi_generator(60, 1)
  #     render :new
  #   end
  # end

  # def edit
  #   @scale = Scale.find_by_slug(params[:scale_slug])
  #   if editable_scale?(@scale)
  #     @note_selection = Note.references
  #     @pattern = @scale.midi_generator(60, 1)
  #   end
  # end

  # def update
  #   @scale = Scale.find(params[:id])
  #   editable_scale?(@scale)
  #   @scale.custom_update(@scale, scale_params)
  #   if @scale.save
  #     go_to(@scale)
  #   else
  #     @note_selection = Note.references
  #     @pattern = @scale.midi_generator(60, 1)
  #     render :edit
  #   end
  # end
  #
  # def most_popular
  #   @most_popular_scale = "Ionian"
  # end

  # def destroy
  #   scale = Scale.find(params[:id]).destroy
  #   editable_scale?(scale)
  #   redirect_to scales_path
  # end

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
      go_to(scale, root = "do", alert = "You can't edit this scale, sorry!")
    else
      true
    end
  end

  def go_to(scale, root = "do", alert = nil)
    redirect_to show_scale_path({scale_slug: scale.slugify, root_note: root}), alert: alert
  end


end
