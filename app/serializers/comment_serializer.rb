class CommentSerializer < ActiveModel::Serializer
  include SerializerAttribute

  type 'data'

  attribute :id, if: :render_id?
  attribute :title, if: :render_title?
  attribute :content, if: :render_content?
  attribute :calification, if: :render_calification?
  belongs_to :order

  def render_id?
    render?(instance_options[:render_attribute].split(","),"comment.id","id")
  end

  def render_title?
    render?(instance_options[:render_attribute].split(","),"comment.title","title")
  end

  def render_content?
    render?(instance_options[:render_attribute].split(","),"comment.content","content")
  end

  def render_calification?
    render?(instance_options[:render_attribute].split(","),"comment.calification","calification")
  end

end
