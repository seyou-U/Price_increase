class UsersController < ApplicationController
  def index
  end

  def show
    favorites = Favorite.where(user_id: current_user.id).pluck(:product_id)
    @favorite_list = Product.find(favorites)
  end

  def edit
  end
end
