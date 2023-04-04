Rails.application.routes.draw do
 
  
  namespace :admin do
    get 'homes/top'
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
    resources:pets, only: [:new, :index, :show, :edit, :update, :destroy]
    resources:posts, only: [:new, :index, :show, :edit, :update, :destroy]
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage' => 'customers#update'
    get 'customers/mypage' => 'customers#show'
    get 'customers/check'
    patch 'customers/withdraw'
    delete 'cart_items/destroy_all'
  end
  
  namespace :admin do
    
    get 'customers/index'
    get 'customers/show'
    get 'customers/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
