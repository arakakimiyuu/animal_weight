class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    customers_mypage_path(resource)
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  #ゲストユーザーでログインできても一覧、詳細は見れても登録、作成、更新、削除はできない
  def reject_guest_customer
    if current_customer.guest?
      redirect_to root_path
    end
  end

end
