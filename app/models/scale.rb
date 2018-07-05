class Scale < ApplicationRecord
  validates :pattern, presence: true
  validates :pattern, uniqueness: true
  validates :name, presence: true
  validates :name, uniqueness: true
end
