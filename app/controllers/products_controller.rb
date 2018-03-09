class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # GET /products
  # GET /products.json
  def index
    sleep 1
    # @products = Product.search(params[:search])
    # if params[:search]
    #   @products = Product.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    # else
    #   @products = Product.find(:all)
      
    # end
    if !session[:is_admin]
      redirect_to root_url
    end
    if params[:search].blank?
      # @products = Product.all.paginate(:page => params[:page], :per_page => 10)
      @products = Product.all
    else
      # @products = Product.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      @products = Product.search(params[:search])
      
    end
   
  end

  # GET /products/1
  # GET /products/1.json
  def show
  if !session[:is_admin]
      redirect_to root_url
    end
  end

  # GET /products/new
  def new
  if !session[:is_admin]
      redirect_to root_url
    end
    puts "[products_controller] New Product"
    
    @product = Product.new
    if Product.last() == nil
      puts "[products_controller] db.product empty, first code generated"
      @genCode = '00001'
    else
      @prevProd = Product.last().prodCode.to_i
      puts "[products_controller] WARNING WARNING"
      puts @prevProd.to_s
      @prevProd = @prevProd +1
      @genCode = @prevProd.to_s.rjust(5, "0")
    end
  end

  # GET /products/1/edit
  def edit
  if !session[:is_admin]
      redirect_to root_url
    end
    @genCode = @product.prodCode
  end

  # POST /products
  # POST /products.json
  def create
    puts "[products_controller] Create Product"
    @product = Product.new(product_params)
    uploaded_io = params[:product][:image]
    # if uploaded_io != nil
    #   @product.pathToImg = @product.prodCategory + '/' + @product.prodCode
    # end
    # uploaded_io.rename(uploaded_io.original_filename, @product.prodCode.to_s)
    if uploaded_io != nil
      File.open(Rails.root.join('app','assets', 'images', @product.prodCategory.to_s.downcase, uploaded_io.original_filename), 'wb') do |file|
        # puts "[products_controller] original file name " +uploaded_io.original_filename.to_s
        # file.rename(uploaded_io.original_filename, @product.prodCode.to_s)
        file.write(uploaded_io.read)
      end
      @product.pathToImg = @product.prodCategory.downcase + '/' + uploaded_io.original_filename
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    uploaded_io = params[:product][:image]
    # if uploaded_io != nil
    #   @product.pathToImg = @product.prodCategory + '/' + @product.prodCode
    # end
    # uploaded_io.rename(uploaded_io.original_filename, @product.prodCode.to_s)
    if uploaded_io != nil
      File.open(Rails.root.join('app','assets', 'images', @product.prodCategory.to_s.downcase, uploaded_io.original_filename), 'wb') do |file|
        # puts "[products_controller] original file name " +uploaded_io.original_filename.to_s
        # file.rename(uploaded_io.original_filename, @product.prodCode.to_s)
        file.write(uploaded_io.read)
      end
      @product.pathToImg = @product.prodCategory.downcase + '/' + uploaded_io.original_filename
    end
    
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.deleted = true
    @product.update_attributes(:deleted => true)  
    # @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:prodCode, :prodCategory, :prodName, :prodDesc, :price)
    end

   
end
