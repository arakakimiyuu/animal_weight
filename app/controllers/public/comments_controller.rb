class Public::CommentsController < ApplicationController

  #編集,更新,削除を別の会員が変えないようにするための記述
  before_action :ensure_current_customer, only: [:destroy]
  #ゲストユーザーでログインできても作成、削除はできない
  before_action :reject_guest_customer, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = current_customer.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save

    @comments = @post.comments.page(params[:page]).per(10)
    @comment = @post.comments.build(customer_id: current_customer.id)
    render "public/posts/show"  #render先にjsファイルを指定
  end

  def destroy
    current_customer.comments.find(params[:id]).destroy
    
    @comments = @post.comments.page(params[:page]).per(10)
    @comment = @post.comments.new(customer_id: current_customer.id)
    render "public/posts/show"  #render先にjsファイルを指定
  end

  #投稿者 = 現在ログインしている会員でない場合
  def ensure_current_customer
     @post = Post.find(params[:post_id] || params[:id] )
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :customer_id, :post_id)
  end
end
