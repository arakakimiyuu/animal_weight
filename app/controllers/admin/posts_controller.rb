class Admin::PostsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:notice] = "削除に成功しました。"
    redirect_to admin_posts_path
  end

end
