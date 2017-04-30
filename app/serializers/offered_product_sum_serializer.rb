class OfferedProductSumSerializer < ActiveModel::Serializer
  attributes :id, :price, :sum_q
  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  has_many :orders, :through => :orderProducts


end
