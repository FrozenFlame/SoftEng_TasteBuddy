Rails.application.routes.draw do

  get 'main_page/index'
  # routes notes:
  # formats:
  # root 
  # regular route format is get '<pageName>' => '<controller>#<function>'
  # get '<THIS PART>' is incidentally the name of the link usually (e.g. in html.erb) this is the link_to "<Text that user sees>", <THIS PART>_path
  # this is also (probably) the name of the method found @ the controller 
  # finally, you can give these custom names if you wish to be pointed at easier (as: part)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'products/search' => 'products#search', as: 'search_products'
  get 'orders/search' => 'orders#search', as: 'search_orders'
  get 'ordersummary' => 'ordersummary#index'
  
  # signup routes
  get 'users' => 'users#new', as: 'signup'
  
  get 'logout' => 'sessions#logout'
  #temporary root: products, it should be front page
  root 'main_page#index'

  resources :products
  resources :orders
  resources :users
  resources :sessions
end
