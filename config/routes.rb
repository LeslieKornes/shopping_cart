Rails.application.routes.draw do
  resources :carts, only: [:show]

  post 'carts/add'
  post 'carts/remove'
  resources :products
  root 'products#index'

  resources :users
  get "signup" => "users#new"

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
end
