require 'rails_helper'

RSpec.feature "Product_favorites", type: :feature do
  describe "値上げ商品一覧ページ" do
    given(:user) { create(:user) }
    given!(:genre) { create(:genre) }
    given!(:product) { create(:product, genre: genre) }

    background do
      sign_in user
      visit product_path(product.id)
    end

    scenario "お気に入りに追加を押した時、お気に入り商品に追加されていること" do
      click_link "お気に入りに追加"
      expect(user.favorites.count).to eq(1)
    end

    scenario "お気に入りに追加を押した場合、リンクがお気に入りに追加からお気に入りから外すに変更されていること" do
      click_link "お気に入りに追加"
      expect(page).to have_link "お気に入りから外す"
      expect(page).to have_no_link "お気に入りに追加"
    end

    scenario "お気に入りから外すを押した場合、リンクがお気に入りから外すからお気に入りに追加に変更されていること" do
      click_link "お気に入りに追加"
      click_link "お気に入りから外す"
      expect(page).to have_link "お気に入りに追加"
      expect(page).to have_no_link "お気に入りから外す"
    end
  end

  describe "お気に入り商品一覧" do
    given(:user) { create(:user) }
    given!(:genre) { create(:genre) }
    given!(:product1) { create(:product, name: "テスト商品1", high_price: 1, genre: genre) }
    given!(:product2) { create(:product, name: "テスト商品2", high_price: 50, genre: genre) }

    background do
      sign_in user
      visit product_path(product1)
      click_link "お気に入りに追加"
      visit users_favorite_path
    end

    scenario "お気に入りに追加した商品のみが表示されていること" do
      expect(page.all(".search-products").length).to eq user.favorites.count
    end

    scenario "お気に入りに追加した商品の名前と値上げ金額が表示されていること" do
      expect(page).to have_content(product1.name)
      expect(page).to have_content(product1.high_price)
      expect(page).to have_no_content(product2.high_price)
      expect(page).to have_no_content(product2.high_price)
    end

    scenario "お気に入り商品の商品詳細ボタンを押したときその商品の詳細画面に遷移すること" do
      click_button "商品詳細"
      expect(current_path).to eq product_path(product1)
    end

    scenario "お気に入り商品のお気に入りを外したとき、お気に入り商品一覧からその商品が含まれていないこと" do
      visit product_path(product1)
      click_link "お気に入りから外す"
      visit users_favorite_path
      expect(page.all(".search-products").length).to eq user.favorites.count
    end
  end
end
