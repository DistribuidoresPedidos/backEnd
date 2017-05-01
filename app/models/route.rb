class Route < ApplicationRecord
  belongs_to :distributor
  has_many :orders
  has_many :coordinates
  validates :name, presence: true

  def self.load_routes(page=1, per_page=10)
    includes(:orders, :coordinates, :distributor )
    .paginate(:page=> page, :per_page=> per_page)
  end

  def self.route_by_id(id)
    includes(:orders, :coordinates, :distributor )
    .find_by_id(id)
  end
  
  def self.route_by_distributor(distributor, page=1, per_page=10) 
      load_routes(page, per_page)
      .where(routes:{
        distributor_id: distributor
      })
  end

  

end


