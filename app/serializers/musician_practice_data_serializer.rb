class MusicianPracticeDataSerializer < ActiveModel::Serializer
  attributes :id, :name, :admin, :image_url
  has_many :practises
end
