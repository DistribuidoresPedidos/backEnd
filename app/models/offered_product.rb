class OfferedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  validates :price, numericality: { less_than_or_equal_to: 0 }, presence: true
end
