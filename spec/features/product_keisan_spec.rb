require 'rails_helper'

RSpec.feature "Product_keisan", type: :feature do
  describe "損失チェックページ" do
    given(:user) { create(:user) }
    given!(:genre) { create(:genre) }
    given!(:product1) { create(:product, name: "テスト商品1", high_price: 1, genre: genre) }
    given!(:product2) { create(:product, name: "テスト商品2", genre: genre) }

    background do
      sign_in user
      visit product_path(product1)
      click_link "この商品で損失チェックする"
    end

    scenario "詳細画面と同じ商品の商品名と値上げ金額が表示されていること" do
      expect(page).to have_content product1.name
      expect(page).to have_content product1.high_price.to_s
    end

    scenario "損失チェックの計算が正しいこと" do
      find("#Text").set(1)
      expect(page).to have_no_content(product1.high_price*1*52)
      click_button "チェックしてみる"
      expect(page).to have_content(product1.high_price*1*52)
    end
  end
end
