class Public::CustomersController < ApplicationController

  before_action :ensure_normal_customer, only: [:update, :withdrow]

  #メールアドレス（guest@example.com）は管理者、ゲストユーザーでも更新、削除できない
  def ensure_normal_customer
    if current_customer.email == 'guest@example.com'
      flash[:notice] = 'ゲストユーザーの更新、削除できません。'
      redirect_to root_path
    end
  end

  def mypost #投稿履歴一覧
    @customer = current_customer
    #自分の投稿ページが見れる記述
    @posts = Post.where(customer_id: @customer.id).page(params[:page]).per(10)
  end

  def mypet #ペット登録履歴一覧
    @customer = current_customer
    @pets = Pet.where(customer_id: @customer.id).page(params[:page]).per(10)
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
    params.require(:customer).permit(:name, :is_delete)
  end

end
