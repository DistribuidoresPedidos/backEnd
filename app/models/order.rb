class Order < ApplicationRecord
  belongs_to :retailer
  belongs_to :route
  has_many :orderProducts
  has_many :comments
  validates :state , :exitDate , :arrivalDate , presence: true
  validates :totalPrice ,numericality: true, presence: true


#ask the attribute
scope :delivered where(state: 'delivered')

def self.load_orders(page=1, per_page=10)
    includes(:retailer, :route)
    .paginate(:page => page, :per_page => per_page)
end 
#retrieve a order
def self.order_by_id(id){
  includes(:retailer, :route)
    .find_by_id(id)
  }
end
#retrieve all retailer's shop --Aks deliveres instead of self? 
def self.delivered.load_order_by_retailer(retailer, page=1, per_page=10)
  includes(:retailer)
    .where( orders:{
      retailer_id: retailer
    }).paginate(:page=> page, :per_page=> per_page)
  end

#retrive all distributor's sell --Aks delivered


  def self.delivered.load_order_by_distributor(distributor, page=1, per_page=10)
    includes(:route)

  end

def self.order_by_arrivDate(date, page=1, per_page=10)
  load_orders(page, per_page)
    .where(arrivalDate: date)
  end 


def self.order_by_exitDate(date, page=1, per_page=10)
  load_orders(page, per_page)
    .where(exitDate: date)
  end 

  def self.order_by_route(route, page=1, per_page=10)
    
  end
  def self.order_by_productOrder(orderProduct)
end 