Rails.application.routes.draw do
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:new, :index, :show, :edit, :create, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :groups, only: [:show, :update, :edit, :create]
    resources :group_users, only: [:show, :edit, :update]
  end

  # Deviseの管理者ログイン/ログアウト
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  # ユーザー用のルーティング
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  root 'homes#top'
  get "/about" => "homes#about", as: "about"

  resources :users, only: [:edit, :destroy, :update, :show]
  resources :genres, only: [:index]
  resources :groups

  # ネストされたresourcesでpostsリソースを管理
  resources :posts, module: :users do
    resources :comments, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
  end  # このendは、postsブロックを閉じるendです
end
