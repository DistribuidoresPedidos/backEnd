class Order < ApplicationRecord
  belongs_to :retailer
  belongs_to :route
  has_many :orderProducts
  has_many :comments
  has_many :offeredProducts, :through => :orderProducts , :source=> :offered_product
  validates :state , presence: true
  validates :totalPrice ,numericality: true, presence: true


  #ask the attribute
  scope :delivered, -> { where(state: 'delivered') }

  def self.load_orders(page=1, per_page=10)
      includes(:orderProducts, :comments, retailer:[:orders], route:[:orders])
      .paginate(:page => page, :per_page => per_page)
  end 
  #retrieve a order
  def self.order_by_id(id)
    includes(:orderProducts, :comments, retailer:[:orders], route:[:orders])
      .find_by_id(id)
    
  end
  #retrieve all retailer's shop --Aks deliveres instead of self? 
  def self.load_order_by_retailer(retailer, page=1, per_page=10)
    load_orders(page, per_page)
      .where( orders:{
        retailer_id: retailer
      }).delivered.paginate(:page=> page, :per_page=> per_page)
   end

  #retrive all distributor's sell --Aks delivered


  def self.load_order_by_distributor(distributor, page=1, per_page=10)
    load_orders(page, per_page)
    .where(routes:{
      distributor_id: distributor 
    }).delivered.paginate(:page=> page, :per_page=> per_page)

  end

  def self.order_by_arrivDate(date, page=1, per_page=10)
    load_orders(page, per_page)
      .where( orders:{
        arrivalDate: date
      })
  end 


  def self.order_by_exitDate(date, page=1, per_page=10)
    load_orders(page, per_page)
    .where(orders:{
      exitDate: date 
    })
  end 

  def self.order_by_route(route, page=1, per_page=10)
    load_orders(page, per_page)
    .where(orders:{
      route_id: route
    }).paginate(:page=> page, :per_page=> per_page)
  end
    
  def self.order_by_orderProduct(orderProduct)
    includes(:orderProducts)
    .where(order_products:{
      id: orderProduct
    })
  end


end 