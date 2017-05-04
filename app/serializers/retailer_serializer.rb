class RetailerSerializer < ActiveModel::Serializer
  include SerializerAttribute

  type 'data'

  attribute :id, if: :render_id?
  attribute :name, if: :render_name?
  attribute :email, if: :render_email?
  attribute :description, if: :render_description?
  attribute :phoneNumber, if: :render_phone?
  attribute :uid, if: :render_uid?
  attribute :photo, if: :render_photo?
  attribute :latitude, if: :render_latitude?
  attribute :longitude, if: :render_longitude?
  attribute :location, if: :render_location?

  has_many :orders
  has_many :comments, :through => :orders

  def render_id?
    render?(instance_options[:render_attribute].split(","),"retailer.id","id")
  end

  def render_name?
    render?(instance_options[:render_attribute].split(","),"retailer.name","name")
  end

  def render_email?
    render?(instance_options[:render_attribute].split(","),"retailer.email","email")
  end

  def render_phone?
    render?(instance_options[:render_attribute].split(","),"retailer.phoneNumber","phoneNumber")
  end

  def render_uid?
    render?(instance_options[:render_attribute].split(","),"retailer.uid","uid")
  end

  def render_photo?
    render?(instance_options[:render_attribute].split(","),"retailer.photo","photo")
  end
  def render_latitude?
    render?(instance_options[:render_attribute].split(","),"retailer.latitude","latitude")
  end

  def render_longitude?
    render?(instance_options[:render_attribute].split(","),"retailer.longitude","longitude")
  end


    def render_location?
      render?(instance_options[:render_attribute].split(","),"retailer.location","location")
    end

  def render_description?
    render?(instance_options[:render_attribute].split(","),"retailer.description","description")
  end
end
