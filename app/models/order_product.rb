class OrderProduct < ApplicationRecord
  belongs_to :offeredProduct
  belongs_to :order
end
