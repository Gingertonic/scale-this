class Note < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :midi_value, presence: true
  validates :midi_value, uniqueness: true
  validates :frequency, presence: true
  validates :frequency, uniqueness: true

  
end
