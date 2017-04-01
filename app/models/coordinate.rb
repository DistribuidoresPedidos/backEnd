class Coordinate < ApplicationRecord
  belongs_to :route
  acts_as_geolocated

  def self.find_by_route_id(id)
  	includes(route:[:orders])
  	.find_by_id(id)
  end

  def self.find_by_product(product_id)
  	includes(route: {distributor: :offeredProducts})
    .where(offered_products:{
        product_id: product_id
    })
  end

end
