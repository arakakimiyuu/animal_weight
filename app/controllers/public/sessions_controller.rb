# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     @customer = Customer.find_by(name: params[:customer][:name])
     # ログインの成功を判断
     #もし名前が見つかった場合かつパスワードがあっているかかつログインしてないかつサインインしてる場合
    if @customer && @customer.valid_password?(params[:customer][:password]) && (@customer.is_delete != true) && sign_in(@customer)
      redirect_to customers_mypage_path
    else
      reject_customer
    end
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    customers_mypage_path(resource)
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path
    flash[:notice] = 'ゲストユーザーとしてログインしました。'
  end

  protected
  # 退会しているかを判断するメソッド
  def reject_customer
    #入力されたnameからアカウントを1件取得
    @customer = Customer.find_by(name: params[:customer][:name])
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @customer && @customer.valid_password?(params[:customer][:password]) && (@customer.is_delete == true)
      message = "退会済みです。再度ご登録をしてご利用ください"
    else
      message = "入力が間違っています"
    end
    #renderの場合flash[:notice], redirect_toの場合notice: message
    redirect_to new_customer_session_path, notice: message
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
