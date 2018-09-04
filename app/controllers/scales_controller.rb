class ScalesController < ApplicationController

  def index
    if current_user
      @scales = Scale.custom_index(current_user)
    else
      @scales = Scale.standard_index
    end
    @types = Scale.types
    respond_to do |f|
      f.html { render 'index' }
      f.json { render json: @scales, each_serializer: SimpleScaleSerializer }
    end
  end

  def show
    @scale = Scale.find_by_slug(params[:scale_slug]) || @scale = Scale.find(params[:scale_slug])
    render json: @scale
  end

  def new
    @scale = Scale.new
    render json: @scale
  end

  def create
    @musician = Musician.find(musician_params[:id])
    @scale = Scale.create_custom(@musician, scale_params)
    if @scale.save
      render json: @scale
    else
      render json: {errors: @scale.errors.full_messages}
    end
  end

  def update
    @scale = Scale.find(params[:id])
    @scale.custom_update(@scale, scale_params)
    if @scale.save
      render json: @scale
    else
      render json: {errors: @scale.errors.full_messages}
    end
  end

  def destroy
    scale = Scale.find(params[:id]).destroy
    render json: {status: "destroyed!"}
  end

  private
  def scale_params
    params.require(:scale).permit(:name, :scale_type, :origin, :melody_rules, :created_by, :private, :pattern => [])
  end

  def musician_params
    params.require(:musician).permit(:id)
  end

end
