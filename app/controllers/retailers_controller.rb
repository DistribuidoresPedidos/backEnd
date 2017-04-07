class RetailersController < ApplicationController
  before_action :set_retailer, only: [:show, :update, :destroy]

  # GET /retailers
  def index
    @retailers = Retailer.load_retailers(params[:page], params[:per_page])
    render json: @retailers,root: "data", adapter: :json
  end

  # GET /retailers/1
  def show
    render json: @retailer,root: "data", adapter: :json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retailer
      @retailer = Retailer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def retailer_params
      params.fetch(:retailer, {})
    end
end
