class Comment < ApplicationRecord
  belongs_to :order
  validates :title , :content , presence: true
  validates :content , length: { minimum:7 }  
  validates :calification , numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5, only_integer: true }

end
