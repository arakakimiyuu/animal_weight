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
    #ソート機能
    if params[:latest]
    #orderデータの取り出し
     @posts = Post.page(params[:page]).per(20).order(date: :DESC) #desc・・・昇順
    elsif params[:old]
     @posts = Post.page(params[:page]).per(20).order(date: :ASC) #asc・・・降順
    else
     @posts = Post.all.page(params[:page]).per(20)
    end
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
    @pet = @post.pet

    #グラフ化用の変数
    @posts = Post.where(pet_id: @post.pet.id)
    #今日のデータ
    today = Date.current
    if params[:post].present?
      #今日の日付の取得
      if params[:post][:date].present?
        today = params[:post][:date].to_date #ago,sinceを使っているため日付型に変更
      end
      #先月のグラフを出す記述
      if params[:post][:range] == 'one_month'
        @posts = Post.where(pet_id: @post.pet.id).where(date: today.ago(1.month)..today)
      #3ヶ月前のグラフを出す記述
      elsif  params[:post][:range] == 'three_month'
        @posts = Post.where(pet_id: @post.pet.id).where(date: today.ago(3.month)..today)
      #1年前のグラフを出す記述
      elsif  params[:post][:range] == 'one_year'
        @posts = Post.where(pet_id: @post.pet.id).where(date: today.ago(1.year)..today)
      else
        # @posts = Post.where(pet_id: @post.pet.id)のデータが出る
      end
      #範囲の設定
      @range = params[:post][:range]
    end
    #来月
    @next_date = today.since(1.month)
    #先月
    @prev_date = today.ago(1.month)
    # maximumメソッド: レシーバーの中で引数が最大の値を返す
    # roundメソッド: 数字を引数で指定の小数点位置で四捨五入した整数
    #/ /正規表現 #gsub 文字列から特定の文字に変換
    #三項演算子を使った記述 postの中身が空の場合dataは0空ではない場合は最大値を表示
    @max_weight = @posts.empty? ? 0 : (@posts.maximum(:weight).gsub(/[^0-9.]/, '').to_f*1.1).round() #最大の体重がその1.1倍表示できる

    #コメント
    @comment = Comment.new
    @all_comments = Comment.all
     #ソート機能
    if params[:latest]
    #orderデータの取り出し
     @comments = @all_comments.where(post_id: @post.id).page(params[:page]).per(10).order(created_at: :DESC) #desc・・・昇順
    elsif params[:old]
     @comments = @all_comments.where(post_id: @post.id).page(params[:page]).per(10).order(created_at: :ASC) #asc・・・降順
    else
     @comments = Comment.where(post_id: @post.id).page(params[:page]).per(10)
    end

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
