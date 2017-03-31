class Distributor < ActiveRecord::Base
  #relationships
  has_many :offeredProducts
  has_many :products, :through => :offeredProducts
  has_many :routes
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,:photo,  presence: true
  validates :email, :phoneNumber, uniqueness: true 


  
end
