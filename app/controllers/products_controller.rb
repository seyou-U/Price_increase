class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    @products = Product.all
    @count = @products.count
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    if params[:search].present? && params[:name].present?
      product_name_ids = Product.where('name LIKE(?)', "%#{params[:search]}%").pluck(:id)
      genre_name_ids = Genre.where("name= ?", params[:name]).pluck(:id)
      @products = Product.where("id IN (?) and genre_id IN (?)", product_name_ids, genre_name_ids)
    elsif params[:search].present? && params[:name].blank?
      product_name_ids = Product.where('name LIKE(?)', "%#{params[:search]}%").pluck(:id)
      genre_name_ids = Genre.all.pluck(:id)
      @products = Product.where("id IN (?) and genre_id IN (?)", product_name_ids, genre_name_ids)
    elsif params[:search].blank? && params[:name].present?
      product_name_ids = Product.all.pluck(:id)
      genre_name_ids = Genre.where("name= ?", params[:name]).pluck(:id)
      @products = Product.where("id IN (?) and genre_id IN (?)", product_name_ids, genre_name_ids)
    else
      @products = Product.all
      redirect_to products_path(@product, @count)
    end
    @count = @products.count
  end

  def keisan
    @products = Product.all
  end

  def product_keisan
    @product = Product.find(params[:id])
  end
end
