class Favorite < ApplicationRecord
  belongs_to :distributor
  belongs_to :retailer

  def self.load_favorites(page=1, per_page=10)
    includes(:distributor, :retailer)
    .paginate(:page => page, :per_page => per_page)
  end

  def self.favorites_by_retailer(retailer_id, page=1, per_page=10)
    load_favorites(page, per_page).where(favorites:{
      retailer_id: retailer_id
    })
  end

  def self.is_favorite(retailer_id, distributor_id)
    load_favorites().where(favorites:{
      retailer_id: retailer_id,
      distributor_id: distributor_id
    }).count
  end

  def self.find_favorite( retailer_id, distributor_id )
    load_favorites().where(favorites:{
      retailer_id: retailer_id,
      distributor_id: distributor_id
    })
  end

end