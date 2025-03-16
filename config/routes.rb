Rails.application.routes.draw do
  # 管理者用のルーティング（namespace）
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:new, :index, :show, :edit, :create, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :groups, only: [:show, :update, :edit, :create]
    resources :group_users, only: [:show, :edit, :update]
  end

  # ユーザー用のルーティング
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }, module: :users
  

  root 'homes#top'
  get "/about" => "homes#about", as: "about"

  resources :users, only: [:edit, :destroy, :update]
  resources :genres, only: [:index]
  resources :groups
  resources :posts
  resources :likes, only: [:create, :destroy]
end
