class DistributorsController < ApplicationController
  before_action :set_distributor, only: [:show, :update, :destroy]

  # GET /distributors
  def index
    @distributors = Distributor.load_distributors(params[:page], params[:per_page])
    render json: @distributors
  end

  # GET /distributors/1
  def show
    render json: @distributor
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distributor
      @distributor = Distributor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def distributor_params
      params.fetch(:distributor, {})
    end
end
