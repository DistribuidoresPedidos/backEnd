class Product < ApplicationRecord
#relationships
    has_many :offeredProducts
	has_many :distributors, :through => :offeredProducts
    validates :name, :category, :weight, :photo, presence: true
    validates :weight , numericality: true

    default_scope {order('products.name ASC')}

    #load distributor's products

    def self.products_by_distributor( distributor , page=1 , per_page=10 )
        joins(:offeredProducts).select("products.id")
        .group("products.id")
        .where(offeredProducts:{

            distributor_id: distributor
        }).paginate(:page => page , :per_page=> per_page )

    #another solution AKS!!
    '''
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
   
    '''

end
