class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  has_many :predict_products, dependent: :destroy
  has_many :favorites, dependent: :destroy
end
