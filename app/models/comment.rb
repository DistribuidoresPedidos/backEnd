class Comment < ApplicationRecord
  belongs_to :order
  validates :title , :content , presence: true
  validates :content , length: { minimum:7 }  
  validates :calification , numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  def self.load_comments(page=1, per_page=10)
    includes(:order)
      .paginate(:page=>page, :per_page=> per_page)
  end

  def self.comment_by_id(id)
    includes(:order)
    .find_by_id(id)
  end

  def self.comments_by_retailer(retailer, page=1, per_page=10)
    load_comments(page, per_page)
    .where(orders:{
      retailer_id: retailer
    })
  end
    

  def self.comments_by_distributor(distributor, page=1, per_page=10)
    includes(order: {route: :distributor})
      .where(routes:{
        distributor_id: distributor 
      }).paginate(:page=> page , :per_page=> per_page)
      
  end

  def self.comments_by_order(order, page=1, per_page=10)
    load_comments(page, per_page) 
    .where(comments:{
      order_id: order
    })
  end

  def self.comment_by_route(route, page=1, per_page=10)
    load_comments(page, per_page)
    .where(orders:{
        route_id: route
    })
  end
end