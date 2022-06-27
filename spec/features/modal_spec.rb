require 'rails_helper'

RSpec.feature "Modal", type: :feature, js: true do
  describe "損失チェックページから商品を選択する際に出てくるモーダル" do
    given(:user) { create(:user) }
    given!(:genre) { create(:genre) }
    given!(:product) { create(:product, genre: genre) }

    background do
      create_list(:product, 32, genre: genre)
      sign_in user
      visit keisan_products_path
      click_button "商品を選択してください"
    end

    scenario "モーダル内に登録されている全ての商品が表示されること" do
      expect(page.all(".productList").length).to eq Product.count
    end

    scenario "モーダル内に値上げ商品の商品名が表示されていること" do
      expect(page).to have_content product.name
    end

    scenario "モーダル内のこの商品を選択を押すと該当の商品の損失チェック画面に遷移すること" do
      first("#selectProduct").click
      expect(current_path).to eq product_keisan_product_path(product.id)
    end

    scenario "モーダル内のHOME画面へを押すとホーム画面に遷移すること" do
      click_link "HOME画面へ"
      expect(current_path).to eq root_path
    end

    scenario "モーダル内の閉じるを押すと損失チェック画面に遷移すること" do
      click_button "閉じる"
      expect(current_path).to eq keisan_products_path
    end
  end
end
