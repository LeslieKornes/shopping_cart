Rails.application.routes.draw do
  root 'products#index'
  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'

  resources :products
end
