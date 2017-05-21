require 'set'
class Retailer < ActiveRecord::Base
  has_many :orders
  has_many :comments, :through => :orders
  has_many :favorites
  has_many :distributors, :through => :favorites

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
           :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,  presence: true
  validates :email, :phoneNumber, uniqueness: true

  scope :ordered_by_id, -> { order(id: :asc) }
  scope :order_by_id, -> (ord) {order("retailers.id #{ord}")}
  scope :order_by_name, -> (ord) {order("retailers.name #{ord}")}

  mount_uploader :photo, PictureUploader

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.latitude_changed? }

  searchkick word_middle: [:name]

  def self.load_retailers(page=1, per_page=10)
    includes(:comments, orders:[:orderProducts])
    .ordered_by_id.paginate(:page => page,:per_page => per_page)
  end


  def self.retailer_by_id(id)
    includes(orders:[:orderProducts, :comments])
    .find_by_id(id)
  end

  def self.retailers_by_ids(ids)
    includes(:comments, orders:[:orderProducts])
    .where(retailers:{
      id: ids
    })
  end

  def self.retailers_by_distributor(distributor, page=1, per_page=10 )
    includes(:comments, orders: [:route])
    .where(routes: {
      distributor_id: distributor
    }).paginate(:page => page,:per_page => per_page)
  end

  def self.retailer_by_category_product(category)
    includes(orders: {offeredProducts: :product})
    .where(products: {
      category: category
    })
  end

  def self.retailer_by_category_products(categories, page=1, per_page=10)
    includes(:comments, orders: {offeredProducts: :product})
    .where(products: {
      category: categories
    }).paginate(:page => page,:per_page => per_page)
  end

  def self.retailer_by_param(q, params, page=1, per_page=10)
    load_retailers(page, per_page).select(params.map &:to_sym).
    search q, fields: [:name], match: :word_middle, misspellings: {below: 5}
  end
  
  def self.suggest_to_distributor(distributor, page=1, per_page=10)
    s1 = Set.new
    possibleRetailers = Retailer.retailers_by_distributor(distributor)
    #routes = distributor.all_routes_id()
    routes = Route.route_by_distributor(distributor, page, per_page)
    routes.each do |i|
      possibleRetailers.each do |j|
        c = Coordinate.within_radius(1000000, j.latitude, j.longitude).find_by_route_id(i.id)
        if c
          s1.add(j.id)
        end
      end
    end

    Retailer.retailers_by_ids(s1.to_a)
  end


  def self.suggest_to_distributor_by_category(distributor, page=1, per_page=10)
    s1 = Set.new
    categories_distributor = Product.categories_by_distributor(distributor);
    possible_retailers = retailer_by_category_products(categories_distributor)
    distributor_coordinates = Coordinate.find_by_distributor(distributor)
    possible_retailers.each do |i|
      c = distributor_coordinates.within_radius(450, i.latitude, i.longitude)
      if c.size() > 0
        s1.add(i.id)
      end
    end
    retailers_by_ids(s1.to_a).paginate(:page => page,:per_page => per_page)
  end


end
