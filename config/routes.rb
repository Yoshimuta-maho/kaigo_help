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
  devise_for :users, skip: :password, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  root 'homes#top'
  get "/about" => "homes#about", as: "about"

  resources :users, only: [:edit, :destroy, :update]
  resources :genres, only: [:index]
  resources :groups, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
end
