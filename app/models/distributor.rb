class Distributor < ActiveRecord::Base
  #relationships
  has_many :offeredProducts
  has_many :products, :through => :offeredProducts
  has_many :routes
  has_many :orders, :through => :routes 
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,:photo,  presence: true
  validates :email, :phoneNumber, uniqueness: true 

  def self.load_distributors(page=1 , per_page=10)
    includes(offeredProducts:[:orderProduct], :products , routes:[:coordinates] , :orders)
    .paginate(:page => page, :per_page => per_page)
  end

  def self.distributor_by_id(id)
    includes(offeredProducts:[:orderProduct], :products , routes:[:coordinates] , :orders)
    .find_by_id(id)
  end

  def self.distributors_by_ids(ids, page = 1, per_page = 10)
    load_distributors(page, per_page)
    .where(:distributors:{
      id: ids 
  })
end

end
