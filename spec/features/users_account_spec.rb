require 'rails_helper'

RSpec.feature "Users_account", type: :feature do
  given(:user) { create(:user, email: "foobar@exaple") }

  background do
    sign_in user
    visit users_path
  end

  describe "アカウント情報ページ" do
    scenario "アカウント情報ページに登録されたユーザー名とメールアドレスが表示されていること" do
      expect(page).to have_content user.username
      expect(page).to have_content user.email
    end
  end

  describe "アカウント編集ページ" do
    scenario "ユーザー名の変更が成功すること" do
      click_link "編集"
      first(".text").set("foobar")
      page.all(".text")[4].set("foobar")
      click_button "更新"
      visit users_path
      expect(page).to have_content("foobar")
    end

    scenario "メールアドレスの変更が成功すること" do
      click_link "編集"
      page.all(".text")[1].set("test@exaple")
      page.all(".text")[4].set("foobar")
      click_button "更新"
      visit users_path
      expect(page).to have_content("test@exaple")
    end

    scenario "ユーザーアイコンの変更が成功すること" do
      click_link "編集"
      attach_file "user[user_image]", File.join(Rails.root, "spec/fixtures/image/test.jpg")
      page.all(".text")[4].set("foobar")
      click_button "更新"
      visit users_path
      expect(page).to have_selector("img[src$='test.jpg']")
    end

    scenario "パスワードの変更が成功すること" do
      click_link "編集"
      page.all(".text")[2].set("testtest")
      page.all(".text")[3].set("testtest")
      page.all(".text")[4].set("foobar")
      click_button "更新"
      visit users_path
      click_link "ログアウト"
      click_link "ログイン"
      first(".text").set("foobar@exaple")
      page.all(".text")[1].set("testtest")
      click_button "ログイン"
      expect(page).to have_content "ログインしました。"
    end

    scenario "現在のパスワードが誤っている場合ユーザー情報の変更ができないこと" do
      click_link "編集"
      first(".text").set("foobar")
      page.all(".text")[4].set("testtest")
      click_button "更新"
      expect(page).to have_content "現在のパスワードは不正な値です"
    end

    scenario "パスワードと確認用のパスワードが異なるときパスワードの変更ができないこと" do
      click_link "編集"
      page.all(".text")[2].set("testtest")
      page.all(".text")[3].set("barbaz")
      page.all(".text")[4].set("foobar")
      click_button "更新"
      expect(page).to have_content "確認用のパスワードとパスワードが異なります"
    end

    scenario "ページ内の戻るリンクが正常に機能すること" do
      click_link "編集"
      click_link "戻る"
      expect(current_path).to eq users_path
    end
  end
end
