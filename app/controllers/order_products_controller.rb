class OrderProductsController < ApplicationController
  before_action :set_order_product, only: [:show, :update, :destroy]

  # GET /order_products
  def index
    @order_products = OrderProduct.load_orderProducts(params[:page], params[:per_page])
    render json: @order_products, root: "data", each_serializer: OrderProductSerializer, render_attribute: params[:select_order_product] || "all"
  end

  # GET /order_products/1
  def show
    render json: @order_product, root: "data", each_serializer: OrderProductSerializer, render_attribute: params[:select_order_product] || "all"
  end

  # POST /order_products
  def create
    @order_product = OrderProduct.new(order_product_params)

    if @order_product.save
      render json: @order_product, status: :created,root: "data",  serializer: OrderProductSerializer, render_attribute: params[:select_order_product] || "all"
    else
      render json: @order_product.errors, status: :unprocessable_entity
    end
  end
  # GET /orders/1/order_products
  def order_products_by_order
    @order_products = OrderProduct.orderProducts_by_order(params[:order_id], params[:page], params[:per_page])
    render json: @order_products, root: "data", each_serializer: OrderProductSerializer, render_attribute: params[:select_order_product] || "all"
  end

  # PATCH/PUT /order_products/1
  def update
    if @order_product.update(order_product_params)
      render json: @order_product, root: "data",  serializer: OrderProductSerializer, render_attribute: params[:select_order_product] || "all"
    else
      render json: @order_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_products/1
  def destroy
    @order_product.destroy
  end

  def how_many_by_param
    @order_products= OrderProduct.how_many_by_param(params[:offered_product_id], params[:param]);
    render json: @order_products, root: "data",  each_serializer: OrderProductSerializer, render_attribute: params[:select_order_product] || "all"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_product
      @order_product = OrderProduct.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_product_params
      params.require(:order_product).permit(:quantity, :price, :offeredProduct_id, :order_id)
    end
end
