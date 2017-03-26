class Order < ApplicationRecord
  belongs_to :retailer
  belongs_to :route
  has_many :orderProducts
  has_many :comments
  validates :state , :exitDate , :arrivalDate , presence: true
  validates :totalPrice ,numericality: true, presence: true

end
