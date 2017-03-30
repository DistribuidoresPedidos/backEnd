class Route < ApplicationRecord
  belongs_to :distributor
  has_many :orders
  has_many :coordinates
  validates :name , :sites , presence: true
end


