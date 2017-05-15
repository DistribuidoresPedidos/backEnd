class Coordinate < ApplicationRecord
  belongs_to :route
  has_one :distributor, through: :route
  acts_as_geolocated

  def self.coordinate_by_id(id)
    includes(route:[:distributor])
    .find_by_id(id)
  end

  def self.find_by_route_id(id)
  	includes(:route)
  	.where(coordinates: {
      route_id: id
    })
  end

  def self.find_by_product(product_id)
  	includes(route: {distributor: :offeredProducts})
    .where(offered_products:{
        product_id: product_id
    })
  end

  def self.find_by_offered_product(offered_product_id)
    includes(route: {distributor: :offeredProducts})
    .where(offered_products:{
        id: offered_product_id
    })
  end

  def self.find_by_distributor(distributor)
    includes(route: {distributor: :offeredProducts})
    .where(distributors:{
      id: distributor  
    })
  end

  def self.close_to_retailer(retailer_id)
    retailer = Retailer.find_by_id(retailer_id)
    Coordinate.within_radius(200, retailer.latitude, retailer.longitude).
    includes(route: {distributor: :offeredProducts})
  end
end
