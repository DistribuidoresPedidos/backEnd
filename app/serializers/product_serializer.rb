class ProductSerializer < ActiveModel::Serializer

  include SerializerAttribute

  type 'data'

  attribute :id, if: :render_id?
  attribute :name, if: :render_name?
  attribute :category, if: :render_category?
  attribute :weight, if: :render_weight?


  has_many :offeredProducts
  has_many :distributors, :through => :offeredProducts

  def render_id?
    render?(instance_options[:render_attribute].split(","),"product.id","id")
  end

  def render_name?
    render?(instance_options[:render_attribute].split(","),"product.name","name")
  end

  def render_category?
    render?(instance_options[:render_attribute].split(","),"product.category","category")
  end

  def render_weight?
    render?(instance_options[:render_attribute].split(","),"product.weight","weight")
  end
  
end
