require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー登録" do
    before do
      @user = build(:user)
    end

    it "ユーザーネーム、メールアドレス、パスワードと確認用のパスワードが正しく入力されていれば登録できること" do
      expect(@user).to be_valid
    end

    it "同じメールアドレスを登録できないこと" do
      user1 = create(:user)
      @user.email = user1.email
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスはすでに存在します")
    end

    it "ユーザーネームが空のとき登録できないこと" do
      @user.username = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ユーザーネームを入力してください")
    end

    it "メールアドレスが空のとき登録できないこと" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスが入力されていません")
    end

    it "パスワードが空のとき登録できないこと" do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードが入力されていません")
    end

    it "確認用パスワードが空のとき登録できないこと" do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("確認用のパスワードとパスワードが異なります")
    end

    it "パスワードが5文字のとき登録できないこと" do
      @user.password = Faker::Lorem.characters(number: 5)
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードが短すぎます(最小6文字)")
    end

    it "パスワードが確認用のパスワードと一致しないとき登録できないこと" do
      @user.password = Faker::Lorem.characters(number: 7)
      @user.password_confirmation = Faker::Lorem.characters(number: 6)
      @user.valid?
      expect(@user.errors.full_messages).to include("確認用のパスワードとパスワードが異なります")
    end

    it "ユーザーネームが31文字のとき登録できないこと" do
      @user.username = Faker::Lorem.characters(number: 31)
      @user.valid?
      expect(@user.errors.full_messages).to include("ユーザーネームは30文字以内で入力してください")
    end

    it "メールアドレスが51文字のとき登録できないこと" do
      @user.email = Faker::Lorem.characters(number: 43) + "@example"
      @user.valid?
      expect(@user.errors.full_messages).to include("メールアドレスは50文字以内で入力してください")
    end
  end
end
