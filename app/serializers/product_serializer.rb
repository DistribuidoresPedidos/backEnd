class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :weight, :photo
  has_many :offeredProducts
	has_many :distributors, :through => :offeredProducts
    
end
