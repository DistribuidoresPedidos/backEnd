class Route < ApplicationRecord
  belongs_to :distributor
  has_many :orders
  validates :name , :sites , presence: true
end
