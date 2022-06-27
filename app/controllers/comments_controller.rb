class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    elsif @comment.comment_content.blank?
      flash[:alert] = "コメントを入力してください"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "コメントは500文字以内で入力してください"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :predict_product_id)
  end
end
