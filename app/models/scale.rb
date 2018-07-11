class Scale < ApplicationRecord
  validates :pattern, presence: true
  validates :pattern, uniqueness: true
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :practises
  has_many :musicians, through: :practises

  def self.custom_index(user)
    Scale.all.select{|s| s.private == false || s.created_by == user.id}.sort_by{|s| s.name}
  end

  def self.create_custom(user, params)
    # byebug
    new_scale = Scale.new(name: params[:name], scale_type: params[:scale_type], origin: params[:origin], melody_rules: params[:melody_rules])
    new_scale.pattern = Scale.custom_pattern(params[:pattern])
    new_scale.private = false if params[:private] == "0"
    new_scale.created_by = user.id
    new_scale.save
    new_scale
  end

  def custom_update(scale, params)
    scale.update(params)
    scale.pattern = Scale.custom_pattern(params[:pattern])
    scale.private = false if params[:private] == "1"
    scale.save
  end

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

  def self.custom_pattern(midi_array)
    # byebug
    pattern = []
    midi_array.shift if midi_array[0] == ""
    midi_array.each_with_index do |note, i|
      (pattern << (midi_array[i+1].to_i - midi_array[i].to_i)) unless i == midi_array.size - 1
    end
    pattern.join
  end

  def slugify
    name.gsub(" ", "-").gsub("#","sharp")
  end

  def self.find_by_slug(slug)
    self.find{|s| s.slugify == slug}
  end

  def not_your_scale(current_user)
    self.private && self.created_by != current_user.id
  end

  def self.types
    all.map{|s|s.scale_type}.uniq
  end
end
