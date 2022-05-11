class Product < ApplicationRecord
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader
  def already_favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
