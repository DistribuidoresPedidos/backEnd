class OrderProduct < ApplicationRecord
  belongs_to :offeredProduct
  belongs_to :order
  validates :quantity, numericality: { less_than_or_equal_to: 0, only_integer: true }, presence: true
	validates :price, numericality: { less_than_or_equal_to: 0 }, presence: true

end
