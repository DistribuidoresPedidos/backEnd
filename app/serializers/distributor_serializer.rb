class DistributorSerializer < ActiveModel::Serializer
  include SerializerAttribute
  type 'data'

  attribute :id, if: :render_id?
  attribute :name, if: :render_name?
  attribute :email, if: :render_email?
  attribute :phoneNumber, if: :render_phone?
  attribute :uid, if: :render_uid?
  attribute :photo, if: :render_photo?
  attribute :latitude, if: :render_latitude?
  attribute :longitude, if: :render_longitude?
  attribute :location, if: :render_location?
  attribute :favorite, if: :render_favorite?  

  has_many :offeredProducts
  has_many :products, :through => :offeredProducts
  has_many :routes
  has_many :orders, :through => :routes

  def render_id?
    render?(instance_options[:render_attribute].split(","),"distributor.id","id")
  end

  def render_name?
    render?(instance_options[:render_attribute].split(","),"distributor.name","name")
  end

  def render_email?
    render?(instance_options[:render_attribute].split(","),"distributor.email","email")
  end

  def render_phone?
    render?(instance_options[:render_attribute].split(","),"distributor.phoneNumber","phoneNumber")
  end

  def render_uid?
    render?(instance_options[:render_attribute].split(","),"distributor.uid","uid")
  end

  def render_photo?
    render?(instance_options[:render_attribute].split(","),"distributor.photo","photo")
  end
  def render_latitude?
    render?(instance_options[:render_attribute].split(","),"distributor.latitude","latitude")
  end

  def render_longitude?
    render?(instance_options[:render_attribute].split(","),"distributor.longitude","longitude")
  end
  def render_location?
    render?(instance_options[:render_attribute].split(","),"distributor.location","location")
  end

  def render_favorite?
    render?(instance_options[:render_attribute].split(","),"distributor.favorite","favorite")
  end

end
