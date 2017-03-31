class OfferedProduct < ApplicationRecord
  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  def self.loads_offeredProduct()
    includes(:product, :distributor, :orderProducts, :price)
  end

end
