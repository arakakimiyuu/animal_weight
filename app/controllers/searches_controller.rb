class SearchesController < ApplicationController

  before_action :authenticate_customer!

  #検索モデル→params[:range]
  #検索方法→params[:search]
  #検索ワード→params[:word]

  def search
    @range = params[:range]

    if @range == "Pet"
      @pets = Pet.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
