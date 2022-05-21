class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @favorite = current_user.favorites.create(product_id: params[:product_id])
    redirect_to product_path(params[:product_id])
  end

  def destroy
    @product = Product.find(params[:product_id])
    @favorite = current_user.favorites.find_by(product_id: @product.id)
    @favorite.destroy
    redirect_to product_path(params[:product_id])
  end

end
