class Musician < ApplicationRecord
  validates :name, uniqueness: {:case_sensitive => false, :message => "is already is use by another musician!"}
  validates :name, :email, presence: {:message => "must be provided."}
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :password, length: {minimum: 6}

  has_secure_password

  has_many :practises
  has_many :scales, through: :practises


  # Class methods
  def self.order_by(by) # order for rankings page
    case by
    when "name"
      where.not(name: 'Admin').order("LOWER(name)")
    when "total-practises"
      joins(:practises).group(:musician_id).order("sum(experience) desc")
    when "last-practised"
      joins(:practises).group(:musician_id).order("practises.updated_at desc")
    end
  end

  def self.from_omniauth(auth) # create from omniauth request
    user = Musician.find_by(uid: auth['uid'])
    if !user
      new_user = Musician.create(password: SecureRandom.hex)
      new_user.name = auth['info']['name']
      new_user.email = auth['info']['email']
      new_user.image_url = auth['info']['image']
      new_user.provider = auth['provider']
      new_user.uid = auth['uid']
      new_user.save
      new_user
    else
      user
    end
  end

  def self.find_by_slug(slug) #find user with name "Al Gakovic" from 'al-gakovic'
    name = slug.split("-").join(" ")
    Musician.where("lower(name) = ?", name.downcase).first
  end


  # Instance methods
  def slugify #make slug from name eg change "Al Gakovic" to "al-gakovic"
    self.name.split(" ").join("-").downcase
  end

  def practised(period) #find which scales user practised in x period
    self.practises.select{|p| p.status == period}
  end

  def practise_log #returns object with k-v pairs of period: [scales]
    periods = ["today", "yesterday", "this week", "this month", "ages ago!"]
    practise_log = {}
    periods.each do |period|
      practise_log[period] = self.practised(period)
    end
    practise_log
  end

  def i_just_practised(scale) # called when user practises a scale again, creates a new practise or increases experience of an existing practise.
    new_practise = self.practises.find_or_create_by(scale_id: scale.id)
    new_practise.increase_experience
    new_practise.save
  end

  def find_scale(scale) #find a scale through a user's practises
    practises.find_by(scale: scale)
  end


end
