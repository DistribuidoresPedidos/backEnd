class OfferedProductsController < ApplicationController
  before_action :set_offered_product, only: [:index,:show, :update, :destroy]

  # GET /offered_products
  def index

    render json: @offered_products, status: :ok
  
  end

  # GET /offered_products/1
  def show
    render json: @offered_product, status: :ok
  end

  # POST /offered_products
  def create
    @offered_product = OfferedProduct.new(offered_product_params)

    if @offered_product.save
      render json: @offered_product, status: :created, location: @offered_product
    else
      render json: @offered_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offered_products/1
  def update
    if @offered_product.update(offered_product_params)
      render json: @offered_product, status: :ok
    else
      render json: @offered_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offered_products/1
  def destroy
    @offered_product.destroy
  end

  def offered_products_by_categories
    @offered_products = OfferedProduct.offered_products_by_categories(params[:categories])
    
    render json: @offered_products , status: :ok
  end

  def suggest_to_retailer
    @offered_products= OfferedProduct.suggest_to_retailer(params[:retailer_id])
    render json: @offered_products , status: :ok
  end

  def offered_products_by_param_retailer
    @offered_products= OfferedProduct.offered_products_by_param_retailer(params[:name], params[:retailer_id])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offered_product

      if params.has_key?(:distributor_id)
        @offered_products = OfferedProduct.offered_products_by_distributor(params[:distributor_id],params[:page], params[:per_page])
      elsif params.has_key?(:retailer_id)
        @offered_products =  OfferedProduct.offered_products_by_retailer(params[:retailer_id],params[:page], params[:per_page])
      else
        @offered_products =  OfferedProduct.load_offered_products(params[:page], params[:per_page])
      end
      @offered_product = @offered_products.offered_product_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offered_product_params
      params.require(:offered_product).permit(:price, :product_id, :distributor_id, :categories, :name, :retailer_id)
    end
end
