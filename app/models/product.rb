class Product < ApplicationRecord
#relationships
    has_many :offeredProducts
	has_many :distributors, :through => :offeredProducts
    validates :name, :category, :weight, :photo, presence: true
    validates :weight , numericality: true

    default_scope {order('products.name ASC')}

    #load distributor's products

    def self.products_by_distributor(distributor, page=1 , per_page=> 10)
        includes(:offeredProducts)
        
        .where(offeredProducts:{
            distributor_id= distributor 
        })
    end
    def self.products_by_param(param, retailerId, page=1 , per_page=10)
        @selected = 'products.name, offeredProducts.price, products.weight, products.photo, distributor.name'
        joins(offeredProducts: :distributors).select(@selected)
        .group("products.id")
        .where("products.name LIKE ?", "#{name.downcase}")
    end

    def self.find_by_retailer(param, retailer, page=1 , per_page=10)
        
    end
'''
    #another solution AKS!!
    
    def self.products_by_distributor(distributor, page=1 , per_page=> 10)
        .includes(:offeredProducts)
        .group("product.id")
        --1
        .where(offeredProducts:{
            distributor_id= distributor 
        })
        --2 or
        .where("offeredproducts.distributor= ?", distributor)
        .references(:offeredProducts)
    end
   ''' 
end
