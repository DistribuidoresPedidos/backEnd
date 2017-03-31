require 'set'
class Retailer < ActiveRecord::Base
  has_many :orders 
  has_many :distributors, :through => :orders
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,  presence: true
  validates :email, :phoneNumber, uniqueness: true


  def self.distributor_by_retailers(retailer, page=1 , per_page=10 )
    includes(orders: :routes).select('distributors.latitude, distributors.longitude')
    .group('distributors.id')
    .where(orders: {
      retailer_id: retailer
    }).paginate(:page => page,:per_page => per_page)
  end

  def self.retailers_by_ids(ids)
    includes(:orders, :distributors)
    .where(retailers: {
      id: ids  
    })
  end

  def self.suggest_to_retailer(retailer, page=1 , per_page=10)
    s1 = Set.new
    possibleDistributors = distributor_by_retailer(retailer)
    #routes = distributor.all_routes_id()
    possibleDistributor.each do |j|
      routes = j.all_routes_id()
      routes.each do |i| 
        c = Coordinates.within_radius(100,retailer.latitude, retailer.longitude).find_by_route_id(i)
        if c.size() > 0
          s1.add(j.id)
        end
      end 
    end

    Distributor.retailers_by_ids(s1.to_a)
  end

  
end