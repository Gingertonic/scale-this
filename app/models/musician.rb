class Musician < ApplicationRecord
  has_secure_password
  has_many :practises
  has_many :scales, through: :practises

  def self.find_by_slug(slug)
    #find user with name "Al Gakovic" from 'al-gakovic'
    name = slug.split("-").join(" ").titleize
    Musician.find_by(name: name)
  end

  def slugify
    self.name.split(" ").join("-").downcase
  end
end
