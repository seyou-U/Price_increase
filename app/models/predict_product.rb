class PredictProduct < ApplicationRecord
  validates :name, presence: true, length: { in: 2..30 }
  validates :explanation, presence: true, length: { in: 2..750 }
  validates :reason, presence: true, length: { in: 2..750 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
end
