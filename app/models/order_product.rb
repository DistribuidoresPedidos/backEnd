class OrderProduct < ApplicationRecord
  belongs_to :offered_product
  belongs_to :order
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  def self.load_orderProducts(page=1, per_page=10)
    	includes(:offered_product, :order)
      .paginate(:page => page, :per_page => per_page)
  end

  def self.orderProduct_by_distributor(distributor, page=1, per_page=10)
    includes(order: {route: :distributor})
    .where(routes:{
        distributor_id: distributor
    }).paginate(:page=> page, :per_page=> per_page)
  end

   def self.orderProduct_by_retailer(retailer, page=1, per_page=10)
    load_orderProducts(page, per_page)
    .where(orders:{
        retailer_id: retailer
    }).paginate(:page => page, :per_page => per_page)
  end

  def self.order_products_by_order(order, page=1, per_page=10)
    load_orderProducts(page, per_page)
    .where(order_products:{
      order_id: order
    }).paginate(:page => page, :per_page => per_page)
  end

  def self.orderProduct_by_route( route, page=1, per_page=10)
    includes(:orders)
    .where({
      orders:{
        route_id: route
      }
    }).paginate(:page => page, :per_page => per_page)
    end

end
