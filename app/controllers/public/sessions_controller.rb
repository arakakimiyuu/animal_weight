# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path
    flash[:notice] = 'ゲストユーザーとしてログインしました。'
  end

  protected
  # 退会しているかを判断するメソッド
  def reject_customer
    #【処理内容1】 入力されたnameからアカウントを1件取得
    @customer = Customer.find_by(name: params[:customer][:name])
    if @customer
      #【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_delete == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_customer_session_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
