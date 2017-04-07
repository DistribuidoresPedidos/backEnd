class OrderProductSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price
  belongs_to :offered_product
  belongs_to :order
  
end
