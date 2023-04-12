class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
    flash[:notice] = "削除に成功しました。"
  end

  private

  def post_params
    params.require(:post).permit(:date, :weight, :feed, :amount_food, :customer_id, :pet_id)
  end
end
