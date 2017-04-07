class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :calification
  belongs_to :order

end
