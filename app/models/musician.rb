class Musician < ApplicationRecord
  has_secure_password
  has_many :practises
  has_many :scales, through: :practises

  def self.from_omniauth(auth)
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

  def self.find_by_slug(slug)
    #find user with name "Al Gakovic" from 'al-gakovic'
    name = slug.split("-").join(" ")
    Musician.where("lower(name) = ?", name.downcase).first
  end

  def slugify
    self.name.split(" ").join("-").downcase
  end

  def practised(period)
    self.practises.select{|p| p.status == period}
  end

  def practise_log
    periods = ["today", "yesterday", "this week", "this month", "ages ago!"]
    practise_log = {}
    periods.each do |period|
      practise_log[period] = self.practised(period)
    end
    practise_log
  end

  def i_just_practised(params)
    new_practise = self.practises.find_or_create_by(params)
    new_practise.increase_experience
    new_practise.save
  end

  def self.order_by(by)
    case by
    when "name"
      order("LOWER(name)")
    when "total-practises"
      joins(:practises).group(:musician_id).order("sum(experience) desc")
    when "last-practised"
      joins(:practises).group(:musician_id).order("practises.updated_at desc")
    end
  end

end
