FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "#{n}円値上げした商品" }
    sequence(:high_price) { |n| "#{n}" }
  end
end
