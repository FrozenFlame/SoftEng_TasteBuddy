class MainPageController < ApplicationController
  def index
    # we're gonna need to have some flags here to determine what results will appear.
    @products = Product.all
  end
    # GET /products/1
  # GET /products/1.json
  def show
  end
 
end
