class Musician < ApplicationRecord
  has_secure_password
  has_many :practises
  has_many :scales, through: :practises
end
