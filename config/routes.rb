Rails.application.routes.draw do
  resources :carts, only: [:show]

  post 'carts/add'
  post 'carts/remove'
  resources :products
  root 'products#index'
end
