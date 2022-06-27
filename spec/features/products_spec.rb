require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "値上げ商品一覧ページ" do
    given(:user) { create(:user) }
    given!(:genre) { create(:genre) }
    given!(:product) { create(:product, genre: genre) }

    background do
      create_list(:product, 32, genre: genre)
      sign_in user
      visit products_path
    end

    scenario "商品の一覧に各商品の商品名と値上げ金額が表示されていること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.high_price.to_s
    end

    scenario "商品名をクリックしたときその商品の詳細ページに遷移すること" do
      click_link product.name
      expect(current_path).to eq product_path(product.id)
    end

    scenario "登録されている全ての商品が表示されること" do
      expect(page.all(".search-products").length).to eq Product.count
    end

    scenario "ヘッダーのロゴをクリックするとホーム画面に遷移すること" do
      find("#home").click
      expect(current_path).to eq root_path
    end

    scenario "TOPへボタンをクリックするとページのトップまでスクロールされること", js: true do
      page.execute_script("window.scroll(0, 1500)")
      click_on "TOPへ"
      sleep 1
      scroll_y = page.evaluate_script('window.pageYOffset')
      expect(scroll_y).to eq(0)
    end
  end

  describe "値上げ商品詳細ページ" do
    given(:user) { create(:user) }
    given!(:genre) { create(:genre) }
    given!(:product) { create(:product, genre: genre) }
    given(:favorite) { create(:favorite, user_id: user.id, product_id: product.id) }

    background do
      sign_in user
      visit product_path(product.id)
    end

    scenario "値上げ商品詳細画面に商品名、値上げ金額、説明、引用が表示されていること" do
      expect(page).to have_content product.name
      expect(page).to have_content product.high_price.to_s
      expect(page).to have_content product.explanation
      expect(page).to have_content product.quote
    end

    scenario "この商品で損失チェックするボタンを押した時、損失チェックページに遷移すること" do
      click_link "この商品で損失チェックする"
      expect(current_path).to eq product_keisan_product_path(product.id)
    end
  end
end
