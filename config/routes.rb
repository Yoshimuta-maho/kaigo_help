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

  resources :users, only: [:edit, :destroy, :update, :show]
  resources :genres, only: [:index]
  resources :groups

  # postsリソースにmodule: :usersを指定。likeリソースもネスト
  resources :posts, module: :users, only: [:index, :show, :edit, :update] do
    resource :like, only: [:create, :destroy]  # Likeのルーティングをpostsにネスト
    resources :comments, only: [:create, :destroy]  # コメントのリソースをネスト
  end

  # 投稿の一覧はusers/postsコントローラで処理
  resources :posts, only: [:index], controller: 'users/posts'  
end

