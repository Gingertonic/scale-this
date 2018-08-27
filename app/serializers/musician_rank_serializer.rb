class MusicianRankSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :practises
end
