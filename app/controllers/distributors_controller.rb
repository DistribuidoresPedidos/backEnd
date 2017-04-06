class DistributorsController < ApplicationController
  before_action :set_distributor, only: [:show, :update, :destroy]
  before_action :authenticate_retailer!, only: [:distributors_by_retailer]
  before_action :authenticate_distributor!, except: [:distributors_by_retailer]
  # GET /distributors
  def index
    @distributors = Distributor.load_distributors(params[:page], params[:per_page])
    render json: @distributors
  end

  # GET /distributors/1
  def show
    render json: @distributor
  end

  def distributors_by_retailer
    @distributors= distributors_by_retailer(params[:retailer_id])
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
