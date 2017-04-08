class OrderSerializer < ActiveModel::Serializer
  	attributes :id, :state, :exitDate, :arrivalDate, :totalPrice
  	belongs_to :retailer
  	belongs_to :route
    has_many :orderProducts
  	has_many :comments
  	has_many :offeredProducts, :through => :orderProducts , :source=> :offered_product
end
