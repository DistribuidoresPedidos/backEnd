class OrderProduct < ApplicationRecord
  belongs_to :offeredProduct
  belongs_to :order
  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  
  def self.load_OrderProducts(page=1, per_page=10)
    	includes(orders:[:orderProducts])
  end

end
