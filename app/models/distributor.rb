
class Distributor < ActiveRecord::Base

  #relationships
  has_many :offeredProducts
  has_many :products, :through => :offeredProducts
  has_many :routes
  has_many :orders, :through => :routes
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable,  :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User
  validates :name, :email, :phoneNumber,  presence: true
  validates :email, :phoneNumber, uniqueness: true

  scope :ordered_by_id, -> { order(id: :asc) }

  mount_uploader :photo, PictureUploader

  reverse_geocoded_by :latitude, :longitude, :address => :location
  after_validation :reverse_geocode, if: ->(obj){ obj.latitude.present? and obj.latitude_changed? }

  searchkick word_middle: [:name]

  def self.load_distributors(page=1, per_page=10)
    includes(:orders, :products, offeredProducts:[:orderProducts], routes:[:coordinates])
    .ordered_by_id.paginate(:page => page, :per_page => per_page)
  end

  def self.distributor_by_id(id, page=1, per_page=10)
    load_distributors(page, per_page)
    .find_by_id(id)
  end

  def self.distributors_by_ids(ids, page = 1, per_page = 10)
    load_distributors(page, per_page)
    .where(distributors:{
      id: ids
    })
  end

  def self.distributors_by_retailer(retailer, page=1, per_page=10 )
    load_distributors(page, per_page)
    .where(orders: {
      retailer_id: retailer
    }).paginate(:page => page,:per_page => per_page)
  end
  def self.distributor_by_param(q, params, page=1, per_page=10)
    load_distributors(page, per_page).select(params.map &:to_sym).
    search q, fields: [:name], match: :word_middle, misspellings: {below: 5}
  end

  def self.distributor_close_to_retailer(retailer_id, page=1, per_page=10)
    retailer = Retailer.retailer_by_id(retailer_id)
    load_distributors(page, per_page)
    .where(coordinates: {
      id: Coordinate.within_radius(500, retailer.latitude, retailer.longitude).pluck(:id)
    }).paginate(:page => page,:per_page => per_page)
  end
end
