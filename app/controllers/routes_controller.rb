class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :update, :destroy]

  # GET /routes
  def index
    @routes = Route.route_by_distributor(params[:distributor_id])
    render json: @routes,root: "data", adapter: :json
  end

  # GET /routes/1
  def show
    @routes = Route.route_by_distributor(params[:distributor_id])
    @route = @routes.route_by_id(params[:id])
    render json: @route,root: "data", adapter: :json
  end

  # POST /routes
  def create
    @route = Route.new(route_params)

    if @route.save
      render json: @route, status: :created,root: "data", adapter: :json
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /routes/1
  def update
    if @route.update(route_params)
      render json: @route,root: "data", adapter: :json
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # DELETE /routes/1
  def destroy
    @route.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.route_by_id(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def route_params
      params.require(:route).permit(:name, :distributor_id)
    end
end
