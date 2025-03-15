Rails.application.routes.draw do
  devise_for :genres
  devise_for :groups
  devise_for :group_users
  devise_for :comments
  devise_for :likes
  devise_for :posts
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  namespace :admin do
    root to: 'homes#top'
    resources :genre, only: [:new, :index, :show, :edit, :create, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :groups, only: [:show, :update, :edit, :create]
    resources :group_users, only: [:show, :edit, :update]
  end
  
  devise_for :users, skip: :password, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  root 'homes#top'
  get "/about" => "homes#about", as: "about"
  resources :homes, only: [:top, :about ]
  resources :users, only: [:edit, :destroy, :update ]
  resources :genre, only: [:index]
  resources :group, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
    post 'add_to_cart', on: :member
    collection do
      delete 'destroy_all'
    end
  root to: 'homes#top'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
