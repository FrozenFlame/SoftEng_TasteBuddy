class MainPageController < ApplicationController
  def index
    # we're gonna need to have some flags here to determine what results will appear.
    @products = Product.all
     @cart = Cart.new
  end
    # GET /products/1
  # GET /products/1.json
  def show
    puts "[main_page_controller] Found prodCode: " +params[:id].to_s
    # we're receving a params[:id] from the outside. (e.g. /item/1 <- 1 is the :id)
    @product = Product.find_by(prodCode: params[:id])
    @cart = Cart.new
    
  end
  
  def loginfirstflash
    puts "[main_page_controller] action attempted before login. denied"
    flash[:notice] = "Please Login first"
    redirect_back(fallback_location: :back)
  end

  def dosloginfirstflash
    puts "[main_page_controller] action attempted before login. denada"
    flash[:notice] = "Please Login first"
    # redirect_back(fallback_location: :back)
    @event = Event.find(params[:id])
    respond_to do |format|
      format.js
    end
    
  end
end
