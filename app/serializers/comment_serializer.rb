class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :calification
  belongs_to :order

end
