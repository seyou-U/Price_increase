class ProductsController < ApplicationController
  def index
    @products = Product.all
    @count = @products.count
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    if  params[:search].present?
      @products = Product.where('name LIKE(?)',"%#{params[:search]}%")
      @count = @products.count
    else
      @products = Product.all
      @count = @products.count
      redirect_to products_path(@product, @count)
    end
  end

  def keisan
    @products = Product.all
  end

  def product_keisan
    @product = Product.find(params[:id])
  end
end
