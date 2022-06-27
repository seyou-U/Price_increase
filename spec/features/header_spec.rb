require 'rails_helper'

RSpec.feature "Header", type: :feature do
  given(:user) { create(:user) }

  describe "ヘッダーメニュー" do
    context "ログイン済みの場合" do
      scenario "ヘッダーメニューがログインしたときのものであること" do
        sign_in user
        visit root_path
        expect(page).to have_link "値上げ商品"
        expect(page).to have_link "損失チェック"
        expect(page).to have_link "値上げ予想"
        expect(page).to have_link "お気に入り商品"
        expect(page).to have_link "アカウント情報"
        expect(page).to have_link "ログアウト"
        expect(page).to have_no_link "ログイン"
        expect(page).to have_no_link "登録する"
      end
    end

    context "未ログインの場合" do
      scenario "ヘッダーメニューがログインしていないときのものであること" do
        visit root_path
        expect(page).to have_link "ログイン"
        expect(page).to have_link "登録する"
        expect(page).to have_no_link "値上げ商品"
        expect(page).to have_no_link "損失チェック"
        expect(page).to have_no_link "値上げ予想"
        expect(page).to have_no_link "お気に入り商品"
        expect(page).to have_no_link "アカウント情報"
        expect(page).to have_no_link "ログアウト"
      end
    end
  end
end
