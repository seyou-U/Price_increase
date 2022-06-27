class Comment < ApplicationRecord
  validates :comment_content, presence: true, length: { maximum: 500 }
  belongs_to :user
  belongs_to :predict_product
end
