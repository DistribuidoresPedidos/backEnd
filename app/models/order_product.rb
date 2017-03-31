class OrderProduct < ApplicationRecord
  belongs_to :offeredProduct
  belongs_to :order
  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  def self.load_orderProduct(page=1, per_page=10)
    includes(:offeredProduct, :order)
    .paginate(:page=> page, :per_page=> per_page)
  end 

  def self.orderProduct_by_distributor(distributor, page=1, per_page=>10)
    includes(order: {route: :distributor})
    .where(routes:{
        distributor_id: distributor
    }).paginate(:page=> page, :per_page=> per_page)
  end

   def self.orderProduct_by_retailer(retailer, page=1, per_page=>10)
    load_orderProduct(page, per_page)
    .where(orders:{
        retailer_id: retailer 
    }).paginate(:page=> page, :per_page=> per_page)
  end

  def self.orderProduct_by_order(order)
    load_orderProduct(page, per_page)  
    .where(order_products:{
      order_id: order
    })
  end

  def self.orderProduct_by_route( route, page=1, per_page=10)
    includes(:order)
    .where{
      orders:{
        route_id: route 
      }
    }
    end  
  
end
