Rails.application.routes.draw do
  get 'ordersummary/index'

  resources :products
  resources :orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'products/search' => 'products#search', as: 'search_products'
end
