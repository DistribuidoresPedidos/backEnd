class Distributor < ActiveRecord::Base
  #relationships
  has_many :offeredProducts
  has_many :products, :through => :offeredProducts
  has_many :routes
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,:photo,  presence: true
  validates :email, :phoneNumber, uniqueness: true 

  def self.load_distributors(page=1 , per_page=10)
    includes(:orders, :products, offeredProducts:[:orderProducts], routes:[:coordinates])
    .paginate(:page => page, :per_page => per_page)
  end

  def self.distributor_by_id(id)
    includes(:orders, :products, offeredProducts:[:orderProducts], routes:[:coordinates])
    .find_by_id(id)
  end

  def self.distributors_by_ids(ids, page = 1, per_page = 10)
    load_distributors(page, per_page)
    .where(distributors:{
      id: ids 
    })
  end

  def self.distributors_by_retailer(retailer, page=1 , per_page=10 )
    includes(:orders)
    .group('distributors.id')
    .where(orders: {
      retailer_id: retailer
    }).paginate(:page => page,:per_page => per_page)
  end
'''
    def self.suggest_to_retailer(retailer, page=1 , per_page=10)
    s1 = Set.new
    possibleDistributors = Distributor.distributors_by_retailer(retailer)
    #routes = distributor.all_routes_id()
    routes = Routes.r
    possibleDistributors.each do |j|
      
      routes.each do |i| 
        c = Coordinates.within_radius(100,retailer.latitude, retailer.longitude).find_by_route_id(i)
        if c.size() > 0
          s1.add(j.id)
        end
      end 
    end

    Retailer.retailers_by_ids(s1.to_a)
  end
'''
end
