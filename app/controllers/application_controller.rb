class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  #ゲストユーザーを拒否
  def reject_guest_customer
    if current_customer.guest?
      redirect_to root_path
    end
  end

end
