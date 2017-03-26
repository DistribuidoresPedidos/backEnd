class OfferedProductsController < ApplicationController
  before_action :set_offered_product, only: [:show, :update, :destroy]

  # GET /offered_products
  def index
    @offered_products = OfferedProduct.all

    render json: @offered_products
  end

  # GET /offered_products/1
  def show
    render json: @offered_product
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
      render json: @offered_product
    else
      render json: @offered_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offered_products/1
  def destroy
    @offered_product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offered_product
      @offered_product = OfferedProduct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def offered_product_params
      params.require(:offered_product).permit(:price, :product_id, :distributor_id)
    end
end
