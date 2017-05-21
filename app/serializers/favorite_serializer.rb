class FavoriteSerializer < ActiveModel::Serializer
  include SerializerAttribute

  type 'data'
  
  attribute :id, if: :render_id?
  has_one :distributor
  has_one :retailer

  def render_id?
    render?(instance_options[:render_attribute].split(","),"comment.id","id")
  end

end
