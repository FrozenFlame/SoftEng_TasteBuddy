class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  
  # GET /orders
  # GET /orders.json
  def index
    sleep 1
    # @orders = Order.all
    if session[:user_id] == nil
      redirect_to root_url
    elsif session[:is_admin]
      if params[:search].blank?
        @orders = Order.all
      else
        @orders = Order.search(params[:search])
        
      end
    else # filtered for user only
      if params[:search].blank?
        @orders = Order.where(orderUser: session[:user_id])
      else
        @orders = Order.searchFiltered(params[:search], session[:user_id])
        
      end
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if session[:user_id] == nil
        redirect_to root_url
    end
  end

  # GET /orders/new
  def new
    # puts "[orders_controller] New Order"
    if session[:user_id] == nil
      redirect_to root_url

    end
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

  # GET /orders/1/edit
  def edit
    # @genCode = @product.prodCode
    if session[:user_id] == nil
      redirect_to root_url
    end
  end

  # POST /orders
  # POST /orders.json
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
