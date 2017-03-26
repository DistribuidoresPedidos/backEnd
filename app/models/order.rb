class Order < ApplicationRecord
  belongs_to :retailer
  belongs_to :route
end
