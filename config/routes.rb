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

  #ゲストユーザー用
  devise_scope :customer do
    post 'customers_guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
    resources:pets, only: [:new, :index, :create, :show, :edit, :update, :destroy]
    resources:posts, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
     #get 'posts/mypage'
     resource :favorites, only: [:create, :destroy]
     resources:comments, only:[:create, :destroy]
    end
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage' => 'customers#update'
    get 'customers/mypage' => 'customers#show'
    #投稿履歴一覧画面
    get 'customers/myindex' => 'customers#myindex'
    get 'customers/mypet' => 'customers#mypet'
    #顧客の退会確認画面
    get 'customers/check'
    #顧客の退会処理(ステータスの更新)
    patch 'customers/withdraw'
  end
  #検索機能
  get "search" => "searches#search"

  namespace :admin do
    get '/' => 'homes#top'
    resources:customers, only:[:index, :show, :edit, :update]
    resources:comments, only:[:index, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
