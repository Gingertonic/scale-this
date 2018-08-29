class MusicianRankSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url
  has_many :practises
end
