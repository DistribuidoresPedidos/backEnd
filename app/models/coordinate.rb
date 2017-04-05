class Coordinate < ApplicationRecord
  belongs_to :route
  acts_as_geolocated

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

end
