class CommentSerializer < ActiveModel::Serializer
  attributes :id, :tittle, :calification
  belongs_to :order

end
