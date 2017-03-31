class OfferedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true


  def self.load_offered_products(page = 1, per_page = 10)
  	includes(:orderProducts, product:[:offeredProducts], distributor:[:routes])
  end

  def self.offered_product_by_id(id)
  	includes(:orderProducts, product:[:offeredProducts], distributor:[:routes])
  	.find_by_id(id)
  end

  def self.offered_products_by_ids(ids, page = 1, per_page = 10)
  	load_offered_products(page, per_page)
  	.where(:offeredProducts:{
  		id: ids	
	})
  end

  def self.offered_products_by_distributor(distributor, page=1, per_page=10)
  	includes(:distributor).select("offeredProducts.*")
  	.where(offeredProducts:{
  		distributor_id: distributor
	}).paginate(:page => page, :per_page=> per_page)
  end
  
end
