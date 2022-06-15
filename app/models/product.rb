class Product < ApplicationRecord
  belongs_to :genre
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :high_price, presence: true
  mount_uploader :image, ImageUploader
  def already_favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
