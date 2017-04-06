class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :authenticate_distributor!, only: [:update, :create, :destroy]
  
  # GET /products
  # GET distributors/:id/products
  def index
  #duda
    if params.has_key?(:distributor_id)
      @products = Product.products_by_distributor(params[:distributor_id],params[:page],params[:per_page])  
    else
      @products = Product.load_products(params[:page],params[:per_page])
    end

    render json: @products, status: :ok
  end

  # GET distributors/:id/products/1
  def show
    render json: @product, status: :ok
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  def products_by_categories
    
    if params.has_key?(:distributor_id)
      @products = Product.categories_by_distributor(params[:distributor_id],params[:page],params[:per_page])
    elsif params.has_key?(:retailer_id)
      @products = Product.categories_by_retailer(params[:retailer_id],params[:page],params[:per_page])
    else
     @products= products_by_categories(params[:category], params[:page],params[:per_page])
    end    
    render json: @products
  
  end 

  def products_by_ids
    ids= set_ids
    @products= Product.products_by_ids(ids, @þage, @per_page)

    render json: @products, status: :ok
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      
      if params.has_key?(:distributor_id)
        @products = Product.products_by_distributor(params[:distributor_id], params[:page],params[:per_page])  
      else
        @products= Product.products_by_ids(params[:id],params[:page],params[:per_page])
      end
    
      @product= @products.product_by_id(params[:id])
      
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :category, :weight, :photo)
    end
     
    def set_ids
        ids = nil
      if params.has_key?(:product)
        ids = params[:product][:ids]
      end
        ids ||= []
        ids
    end
end
