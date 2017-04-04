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

  def self.load_distributors(page=1 , per_page=10)
    includes( :products, offeredProducts:[:orderProducts], routes:[:coordinates])
    .paginate(:page => page, :per_page => per_page)
  end

  def self.distributor_by_id(id)
    includes(:products, offeredProducts:[:orderProducts], routes:[:coordinates])
    .find_by_id(id)
  end

  def self.distributors_by_ids(ids, page = 1, per_page = 10)
    load_distributors(page, per_page)
    .where(distributors:{
      id: ids 
    })
  end

  def self.distributors_by_retailer(retailer, page=1 , per_page=10 )
    includes(routes: [:orders]).select('distributors.id')
    .where(orders: {
      retailer_id: retailer
    }).paginate(:page => page,:per_page => per_page)
  end

end
