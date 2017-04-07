class CoordinateSerializer < ActiveModel::Serializer
  attributes :id, :lat, :lng
  belongs_to :route
end
