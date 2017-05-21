class OrderSerializer < ActiveModel::Serializer

    include SerializerAttribute

    type 'data'

    attribute :id, if: :render_id?
    attribute :state, if: :render_state?
    attribute :exitDate, if: :render_exitDate?
    attribute :arrivalDate, if: :render_arrivalDate?
    attribute :totalPrice, if: :render_totalPrice?

    belongs_to :retailer
  	belongs_to :route
    has_many :orderProducts
  	has_many :comments
  	has_many :offeredProducts, :through => :orderProducts, :source => :offered_product

    def render_id?
      render?(instance_options[:render_attribute].split(","),"order.id","id")
    end

    def render_state?
      render?(instance_options[:render_attribute].split(","),"order.state","state")
    end

    def render_exitDate?
      render?(instance_options[:render_attribute].split(","),"order.exitDate","exitDate")
    end

    def render_arrivalDate?
      render?(instance_options[:render_attribute].split(","),"order.arrivalDate","arrivalDate")
    end
    def render_totalPrice?
      render?(instance_options[:render_attribute].split(","),"order.totalPrice","totalPrice")
    end
end
