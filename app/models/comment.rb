class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :predict_product
end
