class Note < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :midi_value, presence: true
  validates :midi_value, uniqueness: true
  validates :frequency, presence: true
  validates :frequency, uniqueness: true

  def self.get_root(params)
    if params[:root_note]
      root_note = self.solfege_to_midi(params[:root_note])
    else
      root_note = 60
    end
    root_note
  end

  def self.solfege_to_midi(solfege)
    self.find_by(solfege: solfege).midi_value
  end

  def self.references
    self.select{|n| n.reference}
  end

end
