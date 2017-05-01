class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  #before_action :authenticate_distributor!

  # GET /products

  # GET distributors/:id/products
  def index
  #duda
    if params.has_key?(:distributor_id)
      @products = Product.products_by_distributor(params[:distributor_id],params[:page],params[:per_page])
    else
      @products = Product.load_products(params[:page],params[:per_page])
    end

    render json: @products, status: :ok,root: "data", each_serializer: ProductSerializer, render_attribute: params[:select_product] || "all"
  end

  # GET distributors/:id/products/1
  def show
    render json: @product, status: :ok,root: "data",each_serializer: ProductSerializer, render_attribute: params[:select_product] || "all"
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created,root: "data", serializer: ProductSerializer, render_attribute: params[:select_product] || "all"
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product,root: "data",serializer: ProductSerializer, render_attribute: params[:select_product] || "all"
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  def products_by_categories

     @products= Product.products_by_categories(params[:categories],params[:page],params[:per_page])

      render json: @products,root: "data",each_serializer: ProductSerializer, render_attribute: params[:select_product] || "all"

  end




  def categories_by_retailer
      @category_products = Product.categories_by_retailer( params[:retailer_id],params[:page],params[:per_page])
      render json: @category_products,root: "data"
  end


  def categories_by_distributor
      @category_products = Product.categories_by_distributor(params[:distributor_id],params[:page],params[:per_page])
      render json: @category_products,root: "data"
  end

  def products_by_ids
    ids= set_ids
    @products= Product.products_by_ids(ids, params[:page],params[:per_page])

    render json: @products, status: :ok,root: "data"
  end

  def simple_search
    @products = Product.search "a"
    @products.each do |product|
      puts @product.name
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product

      if params.has_key?(:distributor_id)
        @products = Product.products_by_distributor(params[:distributor_id], params[:page],params[:per_page])
      else
        @products= Product.products_by_ids(params[:id],params[:page],params[:per_page])
      end

      @product= @products.product_by_id(params[:id],params[:page],params[:per_page])

    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :category, :weight, :photo)
    end

    def set_ids
        ids = nil
      if params.has_key?(:product)
        ids = params[:product][:ids]
      end
        ids ||= []
        ids
    end
end
