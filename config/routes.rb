Rails.application.routes.draw do
  get 'main_page/index'

  # routes notes:
  # formats:
  # root 
  resources :products
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'products/search' => 'products#search', as: 'search_products'
  get 'orders/search' => 'orders#search', as: 'search_orders'
  get 'ordersummary' => 'ordersummary#index'
  
end
