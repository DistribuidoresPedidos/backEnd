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

  

  def self.suggest_to_distributor(retailer, page=1 , per_page=10)
    s1 = Set.new
    possibleDistributors = Distributor.distributors_by_retailer(retailer)
    #routes = distributor.all_routes_id()
    possibleDistributors.each do |j|
      routes = j.all_routes_id()
      routes.each do |i| 
        c = Coordinates.within_radius(100,retailer.latitude, retailer.longitude).find_by_route_id(i)
        if c.size() > 0
          s1.add(j.id)
        end
      end 
    end

    Retailer.retailers_by_ids(s1.to_a)
  end

end