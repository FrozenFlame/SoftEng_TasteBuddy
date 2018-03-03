class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  # GET /products
  # GET /products.json
  def index
    sleep 1
    # @orders = Order.all
     if params[:search].blank?
      # @products = Product.all.paginate(:page => params[:page], :per_page => 10)
      @orders = Order.all
    else
      # @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      @orders = Order.search(params[:search])
      
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    # puts "[products_controller] New Product"
    
    @order = Order.new
    if Order.last() == nil
      puts "[order_controller] db.order empty, first code generated"
      @genCode = '00001'
    else
      @prevOrd = Order.last().orderCode[1..5].to_i
      @prevOrd = @prevOrd +1
      @genCode = @prevOrd.to_s.rjust(5, "0")
    end
  end

  # GET /products/1/edit
  def edit
    # @genCode = @product.prodCode
  end

  # POST /products
  # POST /products.json
  def create
    puts "[orders_controller] Create Order"
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.deleted = true
    @order.update_attributes(:deleted => true)  
    # @order.destroy
    respond_to do |format|
      format.html { redirect_to order_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def total_price(oC)
    # @pc = Pricecalc.new(oC)
    return Ordrcontentgetter.total_price(oC)
  end
  helper_method :total_price
  
  def get_names(oC)
    return Ordrcontentgetter.get_names(oC)
  end
  helper_method :get_names

   def shorten(str)
      if str.length > 55
        return str[0..55] +"..."
      else
        return str  
      end
    end
    helper_method :shorten
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:orderCode, :orderContents)
    end
end
