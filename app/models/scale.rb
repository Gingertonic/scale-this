class Scale < ApplicationRecord
  validates :pattern, presence: {:message => "needs at least two notes!"}
  validates :pattern, uniqueness: {:message => "already belongs to another scale!"}
  validates :name, presence: true
  validates_format_of :name, :with => /\A([\w\ |(|)|-|\d|\#])*\z/m, :message => "can only contain alphanumeric characters, spaces and the # sign!"
  validates :name, uniqueness: {:case_sensitive => false, :message => "is already is use for another scale!"}
  validates :scale_type, presence: true
  validates_format_of :scale_type, :with => /\A([\w\ |-|(|)\d|\#])*\z/, :message => "can only contain alphanumeric characters, spaces and the # sign!"

  has_many :practises
  has_many :musicians, through: :practises


  # Class methods
  def self.types #returns all the unique scale types
    all.map{|s|s.scale_type}.uniq
  end

  def self.find_by_slug(slug) #eg. find "Jazz minor" from 'jazz-minor'
    find{|s| s.slugify == slug}
  end

  def self.standard_index
    Scale.all.select{|s| s.private == false}.sort_by{|s| s.name}
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
    if params[:private] == "1"
      scale.private = true
    elsif params[:private] == "0"
      scale.private = false
    end
  end

  def slugify #eg. make 'f-sharp' from 'f#'
    name.gsub(" ", "-").gsub("#","sharp")
  end

end
