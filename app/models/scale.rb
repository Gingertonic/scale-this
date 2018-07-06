class Scale < ApplicationRecord
  validates :pattern, presence: true
  validates :pattern, uniqueness: true
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :practises
  has_many :musicians, through: :practises

  def scale_generator(root, octaves)
    self.frequencies(root, octaves)
  end

  def see_notes(root, octaves)
    notes = []
    self.midi_generator(root, octaves).each do |midi_value|
      notes << Note.find_by(midi_value: midi_value).name[0...-1]
    end
    notes
  end

  def frequencies(root, octaves)
    frequencies = []
    self.midi_generator(root, octaves).each do |midi_value|
      frequencies << Note.find_by(midi_value: midi_value).frequency
    end
    frequencies
  end

  def midi_generator(root, octaves)
    degrees = []
    pattern.split("").each do |st_count|
      degrees << st_count.to_i
    end
    midi_array = [root]
    degrees.each do |st_count|
      midi_array << midi_array.last + st_count
    end
    if octaves == 2
      octave_two = []
      midi_array.each do |note|
        octave_two << note + 12
      end
      midi_array.push(octave_two).flatten!.uniq!
    end
    midi_array
  end

end
