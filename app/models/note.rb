class Note < ApplicationRecord
  validates :name, :midi_value, :frequency, presence: true
  validates :name, :midi_value, :frequency, uniqueness: true

# Class methods

  def self.solfege_to_midi(solfege) #converts a solfege name into midi value
    self.find_by(solfege: solfege).midi_value
  end

  def self.midi_to_solfege(value) #converts midi value to solfege name
    self.find_by(midi_value: value).solfege.split("-")
  end

  def self.references #gets the 12 reference notes set
    self.select{|n| n.reference}
  end

  def self.get_root(params) #finds the requested root note from the params object and converts it to midi value or auto sets it to 60 (middle C)
    if params[:root_note]
      root_note = self.solfege_to_midi(params[:root_note])
    else
      root_note = 60
    end
    root_note
  end

end
