require 'rails_helper'

RSpec.describe Product, type: :model do
  it "商品名は必須であること" do
    product = build(:product, name: nil)
    product.valid?
    expect(product.errors.messages[:name]).to include("を入力してください")
  end

  it "値上げ金額は必須であること" do
    product = build(:product, high_price: nil)
    product.valid?
    expect(product.errors.messages[:high_price]).to include("を入力してください")
  end
end
