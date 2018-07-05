class Scale < ApplicationRecord
  validates :pattern, presence: true
  validates :pattern, uniqueness: true
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :practises
  has_many :musicians, through: :practises
end
