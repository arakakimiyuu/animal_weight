class Public::FavoritesController < ApplicationController

  def create
    #ゲストユーザーがいいねを押すとtopページに遷移
    if current_customer.guest?
      render :top
      return
    end
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: @post.id)
    favorite.save
    #非同期化のため削除のリダイレクト先を消す
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
    #非同期化のため削除のリダイレクト先を消す
  end
end
