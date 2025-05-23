Rails.application.routes.draw do
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/update'
    get 'posts/destroy'
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

  namespace :admin do
    root to: "users#index"
    resources :genres
    resources :users do
      member do
        patch :disable
        patch :enable
      end
    end
    resources :posts
    resources :groups
    resources :group_users, only: [:show, :edit, :update]
  end

  root 'homes#top'
  get "/about" => "homes#about", as: "about"

  resources :users, only: [:edit, :destroy, :update, :show]
  scope module: :users do
    resources :genres, only: [:index]
    resources :groups do
      member do
        post :join
        get :chat, to: 'groups#chat'
        delete :leave
      end
      resources :messages, only: [:create]
    end

    # ネストされたresourcesでpostsリソースを管理
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy]
    end  # このendは、postsブロックを閉じるendです
  end
end
