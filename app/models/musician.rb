class Musician < ApplicationRecord
  has_secure_password
  has_many :practises
  has_many :scales, through: :practises

  def self.from_omniauth(auth)
    where(uid: auth['uid']).first_or_create do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      u.provider = auth['provider']
    end
  end

  def self.find_by_slug(slug)
    #find user with name "Al Gakovic" from 'al-gakovic'
    name = slug.split("-").join(" ").titleize
    Musician.find_by(name: name)
  end

  def slugify
    self.name.split(" ").join("-").downcase
  end
end
