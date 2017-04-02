class OfferedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  has_many :orders, :through => :orderProducts
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
  	.where(offered_products:{
  		id: ids	
	})
  end

  def self.offered_products_by_distributor(distributor, page=1, per_page=10)
  	includes(:distributor)
  	.where(offered_products:{
  		distributor_id: distributor
	}).paginate(:page => page, :per_page=> per_page)
  end

  def self.offered_products_by_categories(categories)
    includes(:product, distributor:{routes: :coordinates})
    .where(products:{
        category: categories    
    })
  end

  def self.suggest_to_retailer(retailer_id, page=1, per_page=10)
    s1 = Set.new
    retailer = Retailer.find_by_id(retailer_id)
    category_interests = Product.categories_by_retailer(retailer)
    possible_offered_products = offered_products_by_categories(category_interests)

    possible_offered_products.each do |i|
        c = Coordinate.within_radius(200, retailer.latitude, retailer.longitude).find_by_offered_product(i)
        if c.size() > 0
            s1.add(i)
        end
    end
    s1.to_a
  end
  
end
