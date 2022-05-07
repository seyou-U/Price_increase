class PredictProduct < ApplicationRecord
    validates :name, presence: true
    validates :explanation, presence: true
    validates :reason, presence: true
    belongs_to :user
    mount_uploader :image, ImageUploader
end
