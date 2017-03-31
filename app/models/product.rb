class Product < ApplicationRecord
#relationships
    has_many :offeredProducts
	has_many :distributors, :through => :offeredProducts
    validates :name, :category, :weight, :photo, presence: true
    validates :weight , numericality: true

    default_scope {order('products.name ASC')}

    def self.load_products(page=1 , per_page=10)
        includes(distributors:[:offeredProducts, :products, :routes])
        .paginate(:page => page, :per_page => per_page)        
    end


    def self.products_by_ids(ids, page=1, per_page=10)
        load_products(page, per_page)
        .where(products:{
            id: ids    
        })
    end

    #load distributor's products

    def self.products_by_distributor(distributor, page=1 , per_page=10)
        includes(:offeredProducts)
        .where(offeredProducts:{
            distributor_id: distributor 
        })
    end
    
    def self.products_by_param(param, retailerId, page=1 , per_page=10)
        @selected = 'product.name, offeredProduct.price, product.weight, product.photo, distributor.name'
        joins(offeredProducts: :distributors).select(@selected)
        .group("product.id")
        .where("product.name LIKE ?", "#{name.downcase}")
    end

    def self.products_by_param(param, page=1, per_page=10)
        s1 = Set.new
        products_coordinates = Coordinate.find_by_product(product).group("product.id")
        products_coordinates.each do |i|
            c = Coordinate.within_radius(100, retailer.latitude, retailer.longitude)
            if c.size() > 0
                s1.add(i.product_id)
            end
        end
        Product.products_by_ids(s1, page, per_page)
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
