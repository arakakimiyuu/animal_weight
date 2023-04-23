class SearchesController < ApplicationController

  before_action :authenticate_customer!

  #検索モデル→params[:range]
  #検索方法→params[:search]
  #検索ワード→params[:word]

  def search
    @range = params[:range]

    if @range == "Pet"
      @pets = Pet.looks(params[:search], params[:word]).page(params[:page]).per(20)
    else
      @posts = Post.looks(params[:search], params[:word]).page(params[:page]).per(20)
    end
  end
end
