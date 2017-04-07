class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  # GET /retailers/:id/orders
  def index
    if params.has_key?(:retailer_id)
      @orders = Order.load_order_by_retailer(params[:retailer_id], params[:page], params[:per_page])
    elsif params.has_key?(:distributor_id)
      @orders = Order.load_order_by_distributor(params[:distributor_id], params[:page], params[:per_page])
    else
      @orders = Order.load_orders(params[:page], params[:per_page])
    end
    render json: @orders,root: "data", adapter: :json
  end

  # GET /retailers/:id/orders/1
  # GET /distributors/:id/orders/1  
  def show
    if params.has_key?(:retailer_id)
      @orders = Order.load_order_by_retailer(params[:retailer_id], params[:page], params[:per_page])
    elsif params.has_key?(:distributor_id)
      @orders = Order.load_order_by_distributor(params[:distributor_id], params[:page], params[:per_page])
    else
      @orders = Order.load_orders(params[:page], params[:per_page])
    end
    @order = @orders.order_by_id(params[:id])
    render json: @order,root: "data", adapter: :json
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created,root: "data", adapter: :json
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /retailers/:id/orders/1
  def update
    if @order.update(order_params)
      render json: @order,root: "data", adapter: :json
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  # GET retailer|distributor/:id/orders_by_arrival_date
  def orders_by_arrival_date
   if params.has_key?(:retailer_id)
      @orders = Order.order_by_arrivDate_retailer(params[:retailer_id], params[:arrivalDate], params[:page], params[:per_page])
    elsif params.has_key?(:distributor_id)
      @orders = Order.order_by_arrivDate_distributor(params[:distributor_id], params[:arrivalDate], params[:page], params[:per_page])
    else
      @orders = Order.load_orders(params[:page], params[:per_page])
    end
    render json: @orders,root: "data", adapter: :json
  end

  # GET retailer|distributor/:id/orders_by_exit_date
  def orders_by_exit_date
   if params.has_key?(:retailer_id)
      @orders = Order.order_by_exitDate_retailer(params[:retailer_id], params[:exitDate], params[:page], params[:per_page])
    elsif params.has_key?(:distributor_id)
      @orders = Order.order_by_exitDate_distributor(params[:distributor_id], params[:exitDate], params[:page], params[:per_page])
    else
      @orders = Order.load_orders(params[:page], params[:per_page])
    end
    render json: @orders,root: "data", adapter: :json
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
