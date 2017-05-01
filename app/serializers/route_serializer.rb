class RouteSerializer < ActiveModel::Serializer
  attributes :id, :name

  include SerializerAttribute

  type 'data'

  attribute :id, if: :render_id?
  attribute :name, if: :render_name?

  belongs_to :distributor
  has_many :orders
  has_many :coordinates

  def render_id?
    render?(instance_options[:render_attribute].split(","),"route.id","id")
  end

  def render_name?
    render?(instance_options[:render_attribute].split(","),"route.name","name")
  end

end
