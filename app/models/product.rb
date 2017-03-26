class Product < ApplicationRecord
#relationships
    has_many :offeredProducts
	has_many :distributors, :through => :offeredProducts
    validates :name, :category, :weight, :photo, presence: true
    validates :weight , numericality: true

end
