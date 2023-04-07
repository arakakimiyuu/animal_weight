Rails.application.routes.draw do

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
    resources:pets, only: [:new, :index, :create, :show, :edit, :update, :destroy]
    resources:posts, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
     resource :favorites, only: [:create, :destroy]
     resources:commment, only:[:create, :destroy]
    end
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage' => 'customers#update'
    get 'customers/mypage' => 'customers#show'
    #顧客の退会確認画面
    get 'customers/check'
    #顧客の退会処理(ステータスの更新)
    patch 'customers/withdraw'
  end

  namespace :admin do
    get '/' => 'homes#top'
    resources:customer, only:[:index, :show, :edit, :update]
    resources:commment, only:[:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
