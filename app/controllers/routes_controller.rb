class RoutesController < ApplicationController
  before_action :set_route1, only: [:show, :update, :destroy]

  # GET /routes
  def index
    @routes=Route.load_routes(params[:page], params[:per_page])
    render json: @routes,root: "data", each_serializer: RouteSerializer, render_attribute: params[:select_routes] || "all"
  end

  # GET /routes/1
  def show
    @route = @routes.route_by_id(params[:id])
    render json: @route ,root: "data", each_serializer: RouteSerializer, render_attribute: params[:select_routes] || "all"
  end

  # POST /routes
  def create
    @route = Route.new(route_params)

    if @route.save
      render json: @route, status: :created,root: "data",  serializer: RouteSerializer, render_attribute: params[:select_routes] || "all"
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /routes/1
  def update
    if @route.update(route_params)
      render json: @route,root: "data", serializer: RouteSerializer, render_attribute: params[:select_routes] || "all"
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
      @routes = Route.route_by_distributor(params[:distributor_id])
    end
    def set_route1
      @route = Route.find(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def route_params
      params.require(:route).permit(:name, :distributor_id)
    end
end
