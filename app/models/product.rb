class Product < ApplicationRecord
#relationships
    has_many :offeredProducts
	  has_many :distributors, :through => :offeredProducts
    validates :name, :category, :weight, presence: true
    validates :weight , numericality: true

#  default_scope {order('products.name ASC')}

    searchkick word_middle: [:name]
  #  default_scope {order('products.name ASC')}

    def self.load_products(page=1 , per_page=10)
        includes(:offeredProducts,distributors:[:routes])
        .paginate(:page => page, :per_page => per_page)
    end

    def self.product_by_id(id, page=1, per_page=10)
        load_products(page, per_page)
        .where(products:{
            id: id
        })
    end
    def self.products_by_ids(ids, page=1, per_page=10)
        load_products(page, per_page)
        .where(products:{
            id: ids
        }).paginate(:page => page, :per_page => per_page)
    end

    def self.products_by_categories(categories, page=1, per_page=10)

        where(products:{
            category: categories
        }).paginate(:page => page, :per_page => per_page)
    end

    #load distributor's products

    def self.products_by_distributor(distributor, page=1 , per_page=10)
        load_products(page, per_page)
        .where(offered_products:{
            distributor_id: distributor
        }).paginate(:page => page, :per_page => per_page)
    end


    def self.categories_by_retailer(retailer_id, page=1, per_page=10)
       includes(offeredProducts: {orders: :retailer})
        .where(retailers:{
           id: retailer_id
        })
       .distinct.pluck(:category)

    end

    def self.categories_by_distributor(distributor_id,  page=1, per_page=10)
        products_by_distributor(distributor_id, page, per_page)
        .distinct.pluck(:category)
    end
    def self.categories( page=1, per_page=10)
       load_products(page, per_page)
       .distinct.pluck(:category)

    end


end
