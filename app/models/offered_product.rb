class OfferedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :distributor
end
