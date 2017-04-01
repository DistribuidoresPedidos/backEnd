require 'set'
class Retailer < ActiveRecord::Base
  has_many :orders 
  has_many :comments, :through => :orders
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,  presence: true
  validates :email, :phoneNumber, uniqueness: true

  def self.load_retailers(page=1 , per_page=10)
    includes(orders:[:orderProducts, :comments])
    .paginate(:page => page,:per_page => per_page)
  end

  def self.retailer_by_id(id)
    includes(orders:[:orderProducts, :comments])
    .find_by_id(id)
  end

  def self.retailers_by_ids(ids)
    includes(orders:[:orderProducts, :comments])
    .where(retailers:{
      id: ids 
    })
  end

  def self.retailers_by_distributor(distributor, page=1 , per_page=10 )
    includes(orders: :route)
    .where(routes: {
      distributor_id: distributor
    }).paginate(:page => page,:per_page => per_page)
  end

  


  def self.suggest_to_distributor(distributor, page=1 , per_page=10)
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

end


