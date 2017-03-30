class Retailer < ActiveRecord::Base
  has_many :orders 
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,  presence: true
  validates :email, :phoneNumber, uniqueness: true

"""	def  self.retailers_by_product(product, page=1 , per_page=10)
		joins(retailer: order: )
	end"""
end