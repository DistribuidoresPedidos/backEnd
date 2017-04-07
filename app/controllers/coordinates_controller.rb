class CoordinatesController < ApplicationController
  before_action :set_coordinate, only: [:show, :update, :destroy]

  # GET /coordinates
  def index
    @coordinates = Coordinate.find_by_route_id(params[:route_id])
    render json: @coordinates,root: "data", adapter: :json
  end

  # GET /coordinates/1
  def show
    @coordinates = Coordinate.find_by_route_id(params[:route_id])
    @coordinate = @coordinates.coordinate_by_id(params[:id])
    render json: @coordinate,root: "data", adapter: :json
  end

  # POST /coordinates
  def create
    @coordinate = Coordinate.new(coordinate_params)

    if @coordinate.save
      render json: @coordinate, status: :created,root: "data", adapter: :json
    else
      render json: @coordinate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coordinates/1
  def update
    if @coordinate.update(coordinate_params)
      render json: @coordinate,root: "data", adapter: :json
    else
      render json: @coordinate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coordinates/1
  def destroy
    @coordinate.destroy
  end

  def coordinate_by_ordered_product
    @coordinates = Coordinate.find_by_ordered_product(params[:order__id])
    render json: @coordinates,root: "data", adapter: :json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coordinate
      @coordinate = Coordinate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coordinate_params
      params.fetch(:coordinate, {})
    end
end
