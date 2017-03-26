class Route < ApplicationRecord
  belongs_to :distributor
  has_many :orders
end
