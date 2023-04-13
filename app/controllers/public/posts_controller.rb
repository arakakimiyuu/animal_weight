class Public::PostsController < ApplicationController
  #編集,更新,削除を別の会員がいじらないようにするための記述
  before_action :ensure_current_customer, only: [:edit, :update, :destroy]
  #ゲストユーザーでログインできても一覧、詳細は見れても登録、作成、更新、削除はできない
  before_action :reject_guest_customer, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
    #ペット登録をしないと投稿できないようにif文をつけた
   if current_customer.pets.count == 0
     flash[:notice] = "ペット新規登録をしてから投稿ができるようになります。"
     redirect_to new_pet_path
   end
  end

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id

    if @post.save
       redirect_to post_path(@post)
       flash[:notice] = "新規投稿確認しました。"
    else
      render:new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(10)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
      flash[:notice] = "変更を保存しました。"
    else
      render:edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = "削除に成功しました。"
  end

  #投稿者 = 現在ログインしている会員でない場合
  def ensure_current_customer
     @post = Post.find(params[:id])
     unless @post.customer == current_customer
      redirect_to post_path(@post)
     end
  end

  private

  def post_params
    params.require(:post).permit(:date, :weight, :feed, :amount_food, :customer_id, :pet_id)
  end
end
