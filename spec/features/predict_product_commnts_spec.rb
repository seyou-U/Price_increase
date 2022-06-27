require 'rails_helper'

RSpec.feature "Predict_product_comments", type: :feature do
  given(:user) { create(:user, username: "test") }
  given(:predict_product) { create(:predict_product, user: user) }

  background do
    sign_in user
    visit predict_product_path(predict_product.id)
  end

  describe "値上げ予想商品に対するコメント" do
    scenario "値上げ予想に対してのコメントが正常におこなわれること" do
      find(".comment-text").set("テストテストテスト")
      click_button "コメントする"
      expect(page).to have_content("テストテストテスト")
    end
  end
end
