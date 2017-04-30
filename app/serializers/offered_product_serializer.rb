class OfferedProductSerializer < ActiveModel::Serializer

  include SerializerAttribute

  type 'data'

  attribute :id, if: :render_id?
  attribute :price, if: :render_price?

  belongs_to :product
  belongs_to :distributor
  has_many :orderProducts
  has_many :orders, :through => :orderProducts

  def render_id?
    render?(instance_options[:render_attribute].split(","),"offered_product.id","id")
  end

  def render_price?
    render?(instance_options[:render_attribute].split(","),"offered_product.price","price")
  end

  def render_product_id?
    render?(instance_options[:render_attribute].split(","),"offered_product.product_id","product_id")
  end

  def render_distributor_id?
    render?(instance_options[:render_attribute].split(","),"offered_product.distributor_id","distributor_id")
  end
end
