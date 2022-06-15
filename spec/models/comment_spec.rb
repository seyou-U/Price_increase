require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "コメント機能" do
    it "コメントは必須であること" do
      comment = build(:comment, comment_content: nil)
      comment.valid?
      expect(comment.errors.messages[:comment_content]).to include("を入力してください")
    end

    it "コメントが500文字を超える場合無効になること" do
      comment = build(:comment, comment_content: Faker::Lorem.characters(number: 501))
      comment.valid?
      expect(comment.errors.messages[:comment_content]).to include("は500文字以内で入力してください")
    end
  end
end
