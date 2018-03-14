class MainPageController < ApplicationController
  def index
    @cupcakes_flag = false
    @cakes_flag = false
    @cookies_flag = false
    @bread_flag = false
    @brownies_flag = false
    # we're gonna need to have some flags here to determine what results will appear.
    if params[:search].blank?
      # @products = Product.all.paginate(:page => params[:page], :per_page => 10)
      @products = Product.all
      @products.each do |product|
        if product.prodCategory.casecmp("Cupcakes") == 0 
          if !@cupcakes_flag # has never been true before
            @cupcakes_flag = true 
          end
        end
        if product.prodCategory.casecmp("Cookies") == 0 
          if !@cookies_flag # has never been true before
            @cookies_flag = true 
          end
        end
        if product.prodCategory.casecmp("Cakes") == 0 
          if !@cakes_flag # has never been true before
            @cakes_flag = true
          end
        end
        if product.prodCategory.casecmp("Bread") == 0 
          if !@bread_flag # has never been true before
            @bread_flag = true 
          end
        end
        if product.prodCategory.casecmp("Brownies") == 0 
          if !@brownies_flag # has never been true before
            @brownies_flag = true 
          end
        end
      end
    else
      # @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      @products = Product.search(params[:search])
     
      @products.each do |product|
        if product.prodCategory.casecmp("Cupcakes") == 0 
          if !@cupcakes_flag # has never been true before
            @cupcakes_flag = true 
          end
        end
        if product.prodCategory.casecmp("Cookies") == 0 
          if !@cookies_flag # has never been true before
            @cookies_flag = true 
          end
        end
        if product.prodCategory.casecmp("Cakes") == 0 
          if !@cakes_flag # has never been true before
            @cakes_flag = true
          end
        end
        if product.prodCategory.casecmp("Bread") == 0 
          if !@bread_flag # has never been true before
            @bread_flag = true 
          end
        end
        if product.prodCategory.casecmp("Brownies") == 0 
          if !@brownies_flag # has never been true before
            @brownies_flag = true 
          end
        end
      
      end
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
end
