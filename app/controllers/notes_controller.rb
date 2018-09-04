class NotesController < ApplicationController
  def index
    midiTable = Note.midiTable
    render json: midiTable
  end
end
