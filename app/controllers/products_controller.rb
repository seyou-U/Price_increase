class ProductsController < ApplicationController
  def index
    @products = Product.all
    @count = @products.count
  end

  def show
  end

  def search
    if  params[:search].present?
      @products = Product.where('name LIKE(?)',"%#{params[:search]}%")
      @count = @products.count
    else
      @products = Product.all
      @count = @products.count
      redirect_to products_index_path(@product, @count)
    end
  end
end
