class Admin::CustomersController < ApplicationController
  #ログイン認証が成功していないと表示できない
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(20)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
      flash[:notice] = "変更を保存しました。"
    else
      render:edit
    end
  end

  private

  def customer_params
    #deviceの方に新規登録としてemailは、入っているが編集は入っていないのでいれる
    params.require(:customer).permit(:name, :is_delete, :email)
  end

end
