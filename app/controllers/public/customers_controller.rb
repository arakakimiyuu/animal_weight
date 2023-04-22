class Public::CustomersController < ApplicationController
  #管理者、ゲストユーザーでも更新、削除できない
  before_action :ensure_normal_customer, only: [:update, :withdrow]

  #ゲストのメールアドレスを変えれない
  def ensure_normal_customer
    if current_customer.email == 'guest@example.com'
      flash[:notice] = 'ゲストユーザーの更新、削除できません。'
      redirect_to root_path
    end
  end

  def mypost #投稿履歴一覧
    @customer = current_customer

    #ソート機能
    if params[:latest]
    #orderデータの取り出し
     @posts = Post.where(customer_id: @customer.id).page(params[:page]).per(10).order(created_at: :DESC) #desc・・・昇順
    elsif params[:old]
     @posts = Post.where(customer_id: @customer.id).page(params[:page]).per(10).order(created_at: :ASC) #asc・・・降順
    else
     @posts = Post.where(customer_id: @customer.id).page(params[:page]).per(10)
    end
  end

  def mypet #ペット登録履歴一覧
    @customer = current_customer
    #ソート機能
    if params[:latest]
    #orderデータの取り出し
     @pets = Pet.where(customer_id: @customer.id).page(params[:page]).per(10).order(created_at: :DESC) #desc・・・昇順
    elsif params[:old]
     @pets = Pet.where(customer_id: @customer.id).page(params[:page]).per(10).order(created_at: :ASC) #asc・・・降順
    else
     @pets = Pet.where(customer_id: @customer.id).page(params[:page]).per(10)
    end
  end

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_mypage_path
      flash[:notice] = "変更を保存しました。"
    else
      render:edit
    end
  end

  def check
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_delete: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    #deviceの方に新規登録としてemailは、入っているが編集は入っていないのでいれる
    params.require(:customer).permit(:name, :is_delete, :email)
  end

end
