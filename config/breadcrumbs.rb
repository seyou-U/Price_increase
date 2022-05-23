crumb :root do
  link "Home", root_path
end

crumb :products_list do
  link "値上げ商品リスト", products_path
  parent :root
end

crumb :loss_check do
  link "損失チェック", keisan_products_path
  parent :root
end

crumb :price_increase_forecast do
  link "値上げ予想", predict_products_path
  parent :root
end

crumb :favorite_list do
  link "お気に入り商品一覧", users_favorite_path
  parent :root
end

crumb :account_information do
  link "アカウント情報", users_path
  parent :root
end

crumb :product_show do |product|
  link "#{product.name}", product_path(product)
  parent :products_list
end

crumb :search_products do
  link "検索結果", search_products_path
  parent :products_list
end

crumb :loss_check_product do |product|
  link "損失チェック",  product_keisan_product_path(product)
  parent :root
end

crumb :new_predict_product do
  link "予想投稿ページ", new_predict_product_path
  parent :price_increase_forecast
end

crumb :price_increase_product do |predict_product|
  link "#{predict_product.name}", predict_product_path(predict_product)
  parent :price_increase_forecast
end

crumb :account_edit do |user|
  link "アカウント編集", edit_user_path(user)
  parent :account_information
end
