class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @comments = Comment.all.page(params[:page]).per(10)
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "削除に成功しました。"
    redirect_to admin_comments_path
  end

end
