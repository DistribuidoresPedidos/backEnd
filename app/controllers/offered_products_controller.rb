class OfferedProductsController < ApplicationController
  devise_token_auth_group :member, contains: [:distributor,:retailer]
  before_action :set_offered_product, only: [:index,:show, :update, :destroy]
  #before_action :authenticate_member!, only: [:index, :offered_products_by_categories ]
  #before_action :authenticate_destributor!, only:[:create, :update, :destroy]
  #before_action :authenticate_retailer!, only:[:suggest_to_retailer,:offered_products_by_param_retailer]
  #Pregunta cuando los metodos tienen intercerpción no vacia

  # GET /offered_products
  def index
    render json: @offered_products, status: :ok,root: "data", each_serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#, meta: pagination_dict(@offered_products)
  end

  # GET /offered_products/1
  def show
    render json: @offered_product, status: :ok, root: "data",each_serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#,
  end

  # POST /offered_products
  def create
    @offered_product = OfferedProduct.new(offered_product_params)

    if @offered_product.save
      render json: @offered_product, status: :created,root: "data",serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#,
    else
      render json: @offered_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /offered_products/1
  def update
    if @offered_product.update(offered_product_params)
      render json: @offered_product, status: :ok,root: "data", serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#,
    else
      render json: @offered_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /offered_products/1
  def destroy
    @offered_product.destroy
  end

  def offered_products_by_categories
    @offered_products = OfferedProduct.offered_products_by_categories(params[:category])

    render json: @offered_products , status: :ok, root: "data", adapter: :json
  end

  def suggest_to_retailer
    @offered_products= OfferedProduct.suggest_to_retailer(params[:retailer_id])
    render json: @offered_products , status: :ok, root: "data",each_serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#,
  end

  def offered_products_by_param_retailer
    @offered_products= OfferedProduct.offered_products_by_param_retailer(params[:name], params[:retailer_id])
    render json: @offered_products , status: :ok, root: "data",each_serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#,
  end

  def offered_products_by_param_retailer_match
    @offered_products= OfferedProduct.offered_products_by_param_retailer_match(params[:q], params[:retailer_id], params[:page], params[:per_page])
    render json: @offered_products , status: :ok, root: "data",each_serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#,
  end


  def offered_products_close_to_retailer
    @offered_products= OfferedProduct.offered_products_close_to_retailer(params[:retailer_id], params[:page], params[:per_page])
    @order_params = params[:orderBy].split(',')
    @order_params.each do |param|
      case param
      when 'price'
        @offered_products = @offered_products.order_by_price
      when '-price'
        @offered_products = @offered_products.order_by_price('desc')
      when 'id'
        @offered_products = @offered_products.order_by_id
      when '-id'
        @offered_products = @offered_products.order_by_id('desc')
      else
        @offered_products = @offered_products.order_by_id
      end
    end
    render json: @offered_products , status: :ok, root: "data",each_serializer: OfferedProductSerializer, render_attribute: params[:select_offered_product] || "all"#,
  end

  def offered_products_most_selled
    @offered_products= OfferedProduct.most_selled(params[:top])
    render json: @offered_products, :each_serializer => OfferedProductSumSerializer, status: :ok, root: "data", adapter: :json,  render_attribute: params[:select_offered_product] || "all"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offered_product

      if params.has_key?(:distributor_id)
        @offered_products = OfferedProduct.offered_products_by_distributor(params[:distributor_id],params[:page], params[:per_page])
      elsif params.has_key?(:retailer_id)
        @offered_products =  OfferedProduct.offered_products_by_retailer(params[:retailer_id],params[:page], params[:per_page])
      else
        @offered_products =  OfferedProduct.load_offered_products(params[:page], params[:per_page])
      end
      @offered_product = @offered_products.offered_product_by_id(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def offered_product_params
      params.require(:offered_product).permit(:price, :product_id, :distributor_id)
    end
end
