class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page]).per(10)
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
    params.require(:customer).permit(:name, :is_delete)
  end

end
