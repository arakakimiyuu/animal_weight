class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.page(params[:page]).per(2)
    #@pets = Pet.all
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
    @comments = Comment.all.page(params[:page]).per(2)
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

  private

  def post_params
    params.require(:post).permit(:date, :weight, :feed, :amount_food, :customer_id, :pet_id)
  end
end
