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


  def self.retailers_by_distributor(distributor, page=1 , per_page=10 )
    includes(:orders).select('retailers.latitude, retailers.longitude')
    .group('retailers.id')
    .where(orders: {
      id: distributor  
    }).paginate(:page => page,:per_page => per_page)
  end

  def self.retailers_by_ids(ids)
    includes(:orders, :distributors)
    .where(retailers: {
      id: ids  
    })
  end

  def self.suggest_to_distributor(distributor, page=1 , per_page=10)
    s1 = Set.new
    possibleRetailers = retailers_by_distributor(distributor)
    routes = distributor.all_routes_id()
    routes.each do |i|
      possibleRetailers.each do |j|
        c = Coordinates.within_radius(100,j.latitude, j.longitude).find_by_route_id(i)
        if c.size() > 0
          s1.add(j.id)
        end
      end
    end

    Retailer.retailers_by_ids(s1.to_a)
  end
end

