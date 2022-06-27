require 'rails_helper'

RSpec.feature "Predict_products", type: :feature do
  given(:user1) { create(:user, username: "test") }
  given(:user2) { create(:user, username: "foobar") }

  background do
    sign_in user1
    visit predict_products_path
  end

  describe "値上げ商品予想一覧" do
    context "ログイン完了済みの場合" do
      scenario "値上げ予想の投稿が1つもない場合、値上げ予想商品が一つも表示されないこと" do
        expect(page.all(".post-products").length).to eq 0
      end

      scenario "投稿された値上げ予想商品が一覧ページに含まれていること" do
        click_link "予想投稿ページはこちら"
        within(".information") do
          find(".product-form").set("テスト")
          first(".product-text").set("来年ごろから値上げする予想です")
          page.all(".product-text")[1].set("原材料の高騰によるもの")
          attach_file "predict_product[image]", File.join(Rails.root, "spec/fixtures/image/test.jpg")
          click_button "投稿"
        end
        visit predict_products_path
        within(".post-products") do
          expect(page).to have_selector("img[src$='test.jpg']")
          expect(page).to have_content("テスト")
        end
      end

      scenario "投稿された値上げ予想商品を他のユーザーが確認することができること" do
        click_link "予想投稿ページはこちら"
        within(".information") do
          find(".product-form").set("テスト1")
          first(".product-text").set("来年ごろから値上げする予想です.")
          page.all(".product-text")[1].set("原材料の高騰によるもの.")
          click_button "投稿"
        end
        expect(page).to have_content(user1.username)
        click_link "ログアウト"
        sign_in user2
        visit predict_products_path
        expect(page).to have_content("テスト")
      end
    end

    context "ログインが未完了の場合" do
      scenario "ログインが完了していない場合、値上げ商品予想一覧ページに遷移できないこと" do
        click_link "ログアウト"
        visit predict_products_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "値上げ商品予想投稿" do
    context "ログイン完了済みの場合" do
      scenario "値上げ商品予想投稿が正常におこなえること" do
        click_link "予想投稿ページはこちら"
        within(".information") do
          find(".product-form").set("テスト2")
          first(".product-text").set("来年ごろから値上げする予想です。")
          page.all(".product-text")[1].set("原材料の高騰によるもの。")
          attach_file "predict_product[image]", File.join(Rails.root, "spec/fixtures/image/test.jpg")
          click_button "投稿"
        end
        within(".product-show") do
          expect(page).to have_selector("img[src$='test.jpg']")
          expect(page).to have_content(user1.username)
          expect(page).to have_content("テスト2")
          expect(page).to have_content("来年ごろから値上げする予想です。")
          expect(page).to have_content("原材料の高騰によるもの。")
        end
      end

      scenario "投稿時に画像を選択しない場合、詳細画面の画像が選択されていない時のものになっていること" do
        click_link "予想投稿ページはこちら"
        within(".information") do
          find(".product-form").set("テスト3")
          first(".product-text").set("来年ごろから値上げする予想です!")
          page.all(".product-text")[1].set("原材料の高騰によるもの!")
          click_button "投稿"
        end
        expect(page).to have_selector(".predict-product-image")
      end
    end

    context "ログインが未完了の場合" do
      scenario "ログインが完了していない場合、値上げ商品予想一覧ページに遷移できないこと" do
        click_link "ログアウト"
        visit new_predict_product_path
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end
