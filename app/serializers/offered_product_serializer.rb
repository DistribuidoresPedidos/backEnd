class OfferedProductSerializer < ActiveModel::Serializer
  attributes :id, :price
  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  has_many :orders, :through => :orderProducts
  

end
