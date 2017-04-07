class DistributorSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phoneNumber, :photo, :latitude, :longitude
  has_many :offeredProducts
  has_many :products, :through => :offeredProducts
  has_many :routes
  has_many :orders, :through => :routes
  
end
