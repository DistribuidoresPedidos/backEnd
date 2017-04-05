class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /retailers/:id/orders
  def index
    @orders = Order.load_order_by_retailer(params[:retailer_id], params[:page], params[:per_page])
    render json: @orders
  end

  # GET /retailers/:id/orders/1
  def show
    @order = Order.load_order_by_retailer(params[:retailer_id]).find(params[:id])
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /retailers/:id/orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:state, :exitDate, :arrivalDate, :totalPrice, :retailer_id, :route_id)
    end
end
