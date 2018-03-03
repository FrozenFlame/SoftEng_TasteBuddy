Rails.application.routes.draw do

  # routes notes:
  # formats:
  # root 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'products/search' => 'products#search', as: 'search_products'
  get 'orders/search' => 'orders#search', as: 'search_orders'
  get 'ordersummary' => 'ordersummary#index'
  
  # signup routes
  get 'users' => 'users#new', as: 'signup'
  get 'users/login' => 'users#new', as: 'login'

  #temporary root: products, it should be front page
  root 'products#index'

  resources :products
  resources :orders
  resources :users
  resources :sessions
end
