class Scale < ApplicationRecord
  validates :pattern, presence: true
  validates :pattern, uniqueness: true
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :practises
  has_many :musicians, through: :practises

  def scale_generator(root)
    degrees = []
    pattern.split("").each do |st_count|
      degrees << st_count.to_i
    end
    scale = [root]
    degrees.each do |st_count|
      scale << scale.last + st_count
    end
    scale
  end
end
