Rails.application.routes.draw do

  # use rake routes in order to see your routes so far

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
###############################################################################################################
  # let's try some manual routing for details
  # get 'details' => 'main_page#show'
  # get '/details', controller: 'main_page', action: 'show' # this is the sprawled out version of get 'details' => 'main_page#show'
  # this is actually some method
  # get('/details', {:controller => 'main_page', :action => 'show'}) # this is the non-railsified way
  
  #but we need it to be dynamic
  get '/items/:id' => 'main_page#show', as: 'item' # this is where we go when we click an item from the front page


  get '/cart' => 'cart#show', as: 'cart'
  post '/cart/checkout' => 'cart#checkout', as: 'checkout'
  post '/orders/:id' => 'order#checkout', as: 'confirm_checkout'
  post '/cart' => 'cart#rmv_cart_atindex', as: 'rmv_cart_atindex'
  put '/cart' => 'cart#addToCart', as: 'add_to_cart'

###############################################################################################################
  post '/items' => 'main_page#dosloginfirstflash', as: 'dos_must_be_logged'
  
  get '/items' => 'main_page#loginfirstflash', as: 'must_be_logged'

  root 'main_page#index'

  resources :products
  resources :orders
  resources :users
  resources :sessions
end
