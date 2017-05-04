class RetailersController < ApplicationController
  before_action :set_retailer, only: [:show, :update, :destroy]

  # GET /retailers
  def index
    @retailers = Retailer.load_retailers(params[:page], params[:per_page])
    render json: @retailers, root: "data", each_serializer: RetailerSerializer, render_attribute: params[:select_retailer] || "all"
  end

  # GET /retailers/1
  def show
    render json: @retailer, root: "data", each_serializer: RetailerSerializer, render_attribute: params[:select_retailer] || "all"
  end

  # GET /distributors/:id/suggest_to_distributor_by_category
  def suggest_to_distributor_by_category
    @retailers = Retailer.suggest_to_distributor_by_category(params[:distributor_id], params[:page], params[:per_page])
    render json: @retailers, root: "data", each_serializer: RetailerSerializer, render_attribute: params[:select_retailer] || "all"
  end

  def retailer_by_category_products
    @retailers = Retailer.retailer_by_category_products(params[:categories], params[:page], params[:per_page])
    render json: @retailers, root: "data", each_serializer: RetailerSerializer, render_attribute: params[:select_retailer] || "all"
  end

  def retailer_by_param
    @retailer_by_params= params[:select_retailer].split(',')

    select_colums= @retailer_by_params.map(&:to_sym)

    @select= Retailer.retailer_by_param(params[:q], select_colums)
    render json: @select, status: :ok, root: "data",  each_serializer: RetailerSerializer, render_attribute: params[:select_retailer] || "all"

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
