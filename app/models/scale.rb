class Scale < ApplicationRecord
  validates :pattern, presence: {:message => "needs at least two notes!"}
  validates :pattern, uniqueness: {:message => "already belongs to another scale!"}
  validates :name, presence: true
  validates :name, uniqueness: {:case_sensitive => false, :message => "is already is use for another scale!"}

  has_many :practises
  has_many :musicians, through: :practises


  # Class methods
  def self.types #returns all the unique scale types
    all.map{|s|s.scale_type}.uniq
  end

  def self.find_by_slug(slug) #eg. find "Jazz minor" from 'jazz-minor'
    find{|s| s.slugify == slug}
  end

  def self.custom_index(user)  #returns a list of scales visible to the user (based on permissions and private/public scale status)
    Scale.all.select{|s| s.private == false || s.created_by == user.id}.sort_by{|s| s.name}
  end

  def self.create_custom(user, params) #create a new scale
    new_scale = Scale.new(name: params[:name], scale_type: params[:scale_type], origin: params[:origin], melody_rules: params[:melody_rules])
    new_scale.pattern = Scale.custom_pattern(params[:pattern])
    new_scale.private = false if params[:private] == "0"
    new_scale.created_by = user.id
    new_scale
  end

  def self.custom_pattern(midi_array) #converts the form data into a numerical code that represents the scale
    pattern = []
    midi_array.shift if midi_array[0] == ""
    midi_array.each_with_index do |note, i|
      (pattern << (midi_array[i+1].to_i - midi_array[i].to_i)) unless i == midi_array.size - 1
    end
    pattern.join
  end

  # Instance methods
  def custom_update(scale, params) #update a scale
    scale.update(params)
    scale.pattern = Scale.custom_pattern(params[:pattern])
    scale.private = false if params[:private] == "1"
    scale
  end

  def scale_generator(root, octaves) #returns the frequencies of a scale pattern calculated from the given root note
    frequencies(root, octaves)
  end

  def see_notes(root, octaves) #returns the notes as a scale pattern calculated from the root note
    notes = []
    midi_generator(root, octaves).each do |midi_value|
      notes << Note.find_by(midi_value: midi_value).solfege[0...-1]
    end
    notes
  end

  def frequencies(root, octaves) #helper method for scale_generator
    frequencies = []
    midi_generator(root, octaves).each do |midi_value|
      frequencies << Note.find_by(midi_value: midi_value).frequency
    end
    frequencies
  end

  def midi_generator(root, octaves) #returns the midi values of a scale calculated from the root note
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

  def slugify #eg. make 'f-sharp' from 'f#'
    name.gsub(" ", "-").gsub("#","sharp")
  end

  def not_your_scale(current_user) #checks if the scale is available to the user
    private && created_by != current_user.id
  end

end
