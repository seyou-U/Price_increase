require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "お気に入り機能" do
    it "user_idとproduct_idがあれば登録できること" do
      user = create(:user)
      genre = create(:genre)
      product = create(:product, genre: genre)
      favorite = build(:favorite, user_id: user.id, product_id: product.id)
      expect(favorite).to be_valid
    end
  end
end
