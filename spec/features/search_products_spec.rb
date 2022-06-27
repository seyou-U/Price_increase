require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "値上げ商品リストページの検索機能" do
    context "キーワード検索" do
      given(:user) { create(:user) }
      given!(:genre) { create(:genre) }
      given!(:product1) { create(:product, name: "テスト商品1", genre: genre) }
      given!(:product2) { create(:product, name: "テスト商品2", genre: genre) }
      given!(:product3) { create(:product, name: "該当しない", genre: genre) }

      scenario "入力されたキーワードが含まれている商品のみ表示されること" do
        sign_in user
        visit products_path
        find(".search-form").set("テスト")
        click_button "検索"
        expect(page).to have_content(product1.name)
        expect(page).to have_content(product2.name)
        expect(page).not_to have_content(product3.name)
      end

      scenario "キーワードを何も入力しない状態で検索すると全ての商品が表示されること" do
        sign_in user
        visit products_path
        click_button "検索"
        expect(page).to have_content(product1.name)
        expect(page).to have_content(product2.name)
        expect(page).to have_content(product3.name)
      end
    end

    context "ジャンル検索" do
      given(:user) { create(:user) }
      given!(:genre1) { create(:genre, name: "食料品") }
      given!(:genre2) { create(:genre, name: "消耗品") }
      given!(:product1) { create(:product, name: "テスト商品1", genre: genre1) }
      given!(:product2) { create(:product, name: "テスト商品2", genre: genre2) }

      scenario "プルダウンで指定されたジャンルの商品のみが表示されること" do
        sign_in user
        visit products_path
        select "食料品", from: "name"
        click_button "検索"
        expect(page).to have_content(product1.name)
        expect(page).not_to have_content(product2.name)
      end
    end

    context "キーワードとジャンルによる検索" do
      given(:user) { create(:user) }
      given!(:genre1) { create(:genre, name: "食料品") }
      given!(:genre2) { create(:genre, name: "消耗品") }
      given!(:product1) { create(:product, name: "テスト商品1", genre: genre1) }
      given!(:product2) { create(:product, name: "テスト商品2", genre: genre2) }
      given!(:product3) { create(:product, name: "該当しない", genre: genre1) }

      scenario "指定したジャンルで入力されたキーワードが含まれている商品が表示されること" do
        sign_in user
        visit products_path
        find(".search-form").set("テスト")
        select "食料品", from: "name"
        click_button "検索"
        expect(page).to have_content(product1.name)
        expect(page).not_to have_content(product2.name)
        expect(page).not_to have_content(product3.name)
      end
    end
  end
end
