class RouteSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :distributor
  has_many :orders
  has_many :coordinates
  
end
