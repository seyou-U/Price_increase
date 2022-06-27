class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  validates :username, presence: true, uniqueness: true, length: { maximum: 30, allow_blank: true }
  validates :email, length: { maximum: 50, allow_blank: true }
  has_many :predict_products, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments
  mount_uploader :user_image, UserImageUploader
end
