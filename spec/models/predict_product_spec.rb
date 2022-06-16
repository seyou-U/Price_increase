require 'rails_helper'

RSpec.describe PredictProduct, type: :model do
  describe "値上げ商品予想投稿" do
    it "商品名は必須であること" do
      predict_product = build(:predict_product, name: nil)
      predict_product.valid?
      expect(predict_product.errors.messages[:name]).to include("を入力してください")
    end

    it "説明は必須であること" do
      predict_product = build(:predict_product, explanation: nil)
      predict_product.valid?
      expect(predict_product.errors.messages[:explanation]).to include("を入力してください")
    end

    it "理由は必須であること" do
      predict_product = build(:predict_product, reason: nil)
      predict_product.valid?
      expect(predict_product.errors.messages[:reason]).to include("を入力してください")
    end

    it "商品名が30文字を超える場合無効になること" do
      predict_product = build(:predict_product, name: Faker::Lorem.characters(number: 31))
      predict_product.valid?
      expect(predict_product.errors.messages[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が750文字を超える場合無効になること" do
      predict_product = build(:predict_product, explanation: Faker::Lorem.characters(number: 751))
      predict_product.valid?
      expect(predict_product.errors.messages[:explanation]).to include("は750文字以内で入力してください")
    end

    it "理由が750文字を超える場合無効になること" do
      predict_product = build(:predict_product, reason: Faker::Lorem.characters(number: 751))
      predict_product.valid?
      expect(predict_product.errors.messages[:reason]).to include("は750文字以内で入力してください")
    end
  end
end
