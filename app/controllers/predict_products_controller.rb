class PredictProductsController < ApplicationController

  def new
    @predict_product = PredictProduct.new
  end

  def create
    @predict_product = PredictProduct.new(predict_product_params)
    @predict_product.user_id = current_user.id
    if @predict_product.save
      redirect_to predict_product_path(@predict_product)
     else
      render "new"
    end
  end

  def index
    @predict_products = PredictProduct.all
  end

  def show
    @predict_product = PredictProduct.find(params[:id])
    @user = @predict_product.user
  end

  private
  def predict_product_params
    params.require(:predict_product).permit(:name, :explanation, :reason, :image).merge(user_id: current_user.id)
  end
end
