class SimpleScaleSerializer < ActiveModel::Serializer
  attributes :id, :name, :scale_type, :pattern
end
