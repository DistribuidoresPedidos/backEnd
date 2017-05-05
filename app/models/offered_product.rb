class OfferedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  has_many :orders, :through => :orderProducts
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  #change table
  mount_uploader :photo, PictureUploader

  scope :order_by_id, -> (ord) {order("offered_products.id #{ord}")}
  scope :order_by_price, -> (ord) {order("offered_products.price #{ord}")}
  
  #ElasticSearch
  searchkick

#Solo returna los que han sido ordenados , más no todos los offeredProducts
  def self.load_offered_products(page = 1, per_page = 10)
  	includes( :product,:orders, :orderProducts, distributor:[:routes])
    .paginate(:page => page, :per_page=> per_page)
  end

  def self.offered_product_by_id(id, page=1, per_page=10)
  	load_offered_products(page, per_page)
  	.find_by_id(id)
  end

  def self.offered_products_by_ids(ids, page = 1, per_page = 10)
  	load_offered_products(page, per_page)
  	.where(offered_products:{
  		id: ids
	}).paginate(:page => page, :per_page=> per_page)
  end

  def self.offered_products_by_distributor(distributor, page=1, per_page=10)
  	load_offered_products(page, per_page)
  	.where(offered_products:{
  		distributor_id: distributor
	}).paginate(:page => page, :per_page=> per_page)
  end

  def self.offered_products_by_retailer(retailer_id, page=1, per_page=10)
    load_offered_products(page, per_page)
    .where(orders:{
      retailer_id: retailer_id
    }).paginate(:page => page, :per_page=> per_page)
end
  def self.offered_products_by_categories(categories, page=1, per_page=10)
    load_offered_products(page, per_page)
    .where(products:{
        category: categories
    }).paginate(:page => page, :per_page=> per_page)
  end

  def self.most_selled(top)
      joins(:orderProducts).group(:id).select("offered_products.*, sum( order_products.quantity) as sum_q").order("sum_q DESC").limit(top)
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

  def self.offered_products_by_param_match(param, categories, min_price, max_price)
    includes(:product, distributor:{routes: :coordinates})
    .where(products:{
      id: (Product.search param, fields: [:name], match: :word_middle, misspellings: {below: 5}).pluck(:id),
      category: categories
    },
    offered_products:{
      price: min_price..max_price
    })
  end

  def self.offered_products_by_param_match_all(param)
    includes(:product, distributor:{routes: :coordinates})
    .where(products:{
      id: (Product.search param, fields: [:name], match: :word_middle, misspellings: {below: 5}).pluck(:id)
    })
  end

  def self.simple_search(param, category)
      Product.search param, aggs: [category], fields: [:name], match: :word_middle, misspellings: {below: 5}
  end

  def self.offered_products_by_param(param, page=1, per_page=10)
    includes(:product, distributor:{routes: :coordinates})
    .where(products:{
      name: param
    })
  end
  def self.offered_products_by_select(params, page=1, per_page=10)
    load_offered_products(page, per_page)
    .select(params)
  end

  def self.offered_products_close_to_retailer(retailer_id, page=1, per_page=10)
    retailer = Retailer.retailer_by_id(retailer_id)
    joins(:product, distributor:{routes: :coordinates})
    .merge(Coordinate.within_radius(400, retailer.latitude, retailer.longitude))
    .paginate(:page => page, :per_page=> per_page)
  end


  def self.offered_products_by_param_retailer(param, retailer_id, page=1, per_page=10)
    s1 = Set.new
    retailer = Retailer.retailer_by_id(retailer_id)
    possible_offered_product = offered_products_by_param(param)
    possible_offered_product.each do |i|
      coordinates = Coordinate.find_by_offered_product(i)
      c = coordinates.within_radius(20000, retailer.latitude, retailer.longitude)
      if c.size() > 0
        s1.add(i)
      end
    end
    s1.to_a
  end

  def self.offered_products_by_param_retailer_match(param, retailer_id, page=1, per_page=10)
    s1 = Set.new
    retailer = Retailer.retailer_by_id(retailer_id)
    possible_offered_product = offered_products_by_param_match_all(param)
    possible_offered_product.each do |i|
      coordinates = Coordinate.find_by_offered_product(i)
      c = coordinates.within_radius(20000, retailer.latitude, retailer.longitude)
      if c.size() > 0
        s1.add(i)
      end
    end
    s1.to_a.paginate(:page => page, :per_page=> per_page)
  end

end
