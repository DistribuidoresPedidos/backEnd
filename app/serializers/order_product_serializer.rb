class OrderProductSerializer < ActiveModel::Serializer

  include SerializerAttribute

  type 'data'

  attribute :id, if: :render_id?
  attribute :quantity, if: :render_quantity?
  attribute :price, if: :render_price?
  belongs_to :offered_product
  belongs_to :order

  def render_id?
    render?(instance_options[:render_attribute].split(","),"order_product.id","id")
  end

  def render_quantity?
    render?(instance_options[:render_attribute].split(","),"order_product.quantity","quantity")
  end

  def render_price?
    render?(instance_options[:render_attribute].split(","),"order_product.price","price")
  end
end
