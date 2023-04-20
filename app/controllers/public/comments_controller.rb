class Public::CommentsController < ApplicationController

  #編集,更新,削除を別の会員が変えないようにするための記述
  before_action :ensure_current_customer, only: [:destroy]


  def create
    if current_customer.guest?
      render :top
      return
    end
    @post = Post.find(params[:post_id])
    comment = current_customer.comments.new(comment_params)
    comment.post_id = @post.id

    comment.save
    @comments = @post.comments.page(params[:page]).per(10)
    render:comment
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy

    @comments = @post.comments.page(params[:page]).per(10)
    render:comment
  end

  #投稿者 = 現在ログインしている会員でない場合
  def ensure_current_customer
    comment = Comment.find(params[:id])
    unless comment.customer == current_customer
    redirect_to post_path(comment.post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :customer_id, :post_id)
  end
end
