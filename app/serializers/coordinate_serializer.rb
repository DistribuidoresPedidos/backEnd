class CoordinateSerializer < ActiveModel::Serializer

  include SerializerAttribute

  type 'data'

  attribute :id, if: :render_id?
  attribute :lat, if: :render_lat?
  attribute :lng, if: :render_lng?

  belongs_to :route

  def render_id?
    render?(instance_options[:render_attribute].split(","),"coordinate.id","id")
  end

  def render_lat?
    render?(instance_options[:render_attribute].split(","),"coordinate.lat","lat")
  end

  def render_lng?
    render?(instance_options[:render_attribute].split(","),"coordinate.lng","lng")
  end


end
