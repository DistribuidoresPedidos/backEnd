class Comment < ApplicationRecord
  belongs_to :order
  validates :title , :content , presence: true
  validates :content , length: { minimum:7 }  

end
