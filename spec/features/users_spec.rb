require 'rails_helper'

RSpec.feature "Users_account", type: :feature do
  given!(:user) { create(:user, email: "foobar@exaple") }

  describe "ログイン、ログアウト" do
    context "正しいメールアドレスとパスワードを入力した場合" do
      scenario "正常にログインできること" do
        visit new_user_session_path
        first(".text").set("foobar@exaple")
        page.all(".text")[1].set("foobar")
        click_button "ログイン"
        expect(current_path).to eq root_path
        expect(page).to have_content "ログインしました。"
      end
    end

    context "正しくないメールアドレスとパスワードを入力した場合" do
      scenario "ログインが失敗し、エラーメッセージが表示されること" do
        visit new_user_session_path
        first(".text").set("test@exaple")
        page.all(".text")[1].set("testtest")
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end

    context "ログアウトする場合" do
      scenario "正常にログアウトできること" do
        visit new_user_session_path
        sign_in user
        visit root_path
        click_link "ログアウト"
        expect(current_path).to eq root_path
        expect(page).to have_content "ログアウトしました。"
      end
    end

    context "ログインしている状態でログインページにアクセスする場合" do
      scenario "ホーム画面にリダイレクトされ、エラーメッセージが表示されること" do
        sign_in user
        visit new_user_session_path
        expect(current_path).to eq root_path
        expect(page).to have_content "すでにログインしています。"
      end
    end
  end

  describe "新規登録" do
    context "正しく入力した場合" do
      scenario "新規登録が成功すること" do
        visit new_user_registration_path
        within(".new_user") do
          first(".text").set("テスト")
          page.all(".text")[1].set("test@exaple.com")
          page.all(".text")[2].set("testtest")
          page.all(".text")[3].set("testtest")
          click_button "新しいアカウントを作成"
        end
        expect(current_path).to eq root_path
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "既に登録されているユーザーネームを入力した場合" do
      scenario "新規登録が失敗すること" do
        visit new_user_registration_path
        first(".text").set("test")
        click_button "新しいアカウントを作成"
        expect(current_path).to eq users_path
        expect(page).to have_content "ユーザーネームはすでに存在します"
      end
    end

    context "既に登録されているメールアドレスを入力した場合" do
      scenario "新規登録が失敗すること" do
        visit new_user_registration_path
        page.all(".text")[1].set("foobar@exaple")
        click_button "新しいアカウントを作成"
        expect(current_path).to eq users_path
        expect(page).to have_content "メールアドレスはすでに存在します"
      end
    end

    context "パスワードが短すぎる場合" do
      scenario "新規登録が失敗すること" do
        visit new_user_registration_path
        page.all(".text")[2].set("foo")
        click_button "新しいアカウントを作成"
        expect(current_path).to eq users_path
        expect(page).to have_content "パスワードが短すぎます(最小6文字)"
      end
    end

    context "パスワードと確認用のパスワードが異なる場合" do
      scenario "新規登録が失敗すること" do
        visit new_user_registration_path
        page.all(".text")[2].set("foo")
        page.all(".text")[3].set("bar")
        click_button "新しいアカウントを作成"
        expect(current_path).to eq users_path
        expect(page).to have_content "確認用のパスワードとパスワードが異なります"
      end
    end
  end
end
