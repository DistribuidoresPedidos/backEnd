class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :update, :destroy]

  # GET /:retailer_id/favorites
  def index
    @favorites = Favorite.favorites_by_retailer(params[:retailer_id], params[:page], params[:per_page])
    render json: @favorites, root: "data", each_serializer: FavoriteSerializer, render_attribute: params[:select_favorite] || "all"#, meta: pagination_dict(@comments)

  end

  # GET /:retailer_id/favorites/1
  def show
    render json: @favorite
    render json: @favorite,root: "data", each_serializer: FavoriteSerializer , render_attribute: params[:select_favorite] || "all"

  end

  # POST /:retailer_id/favorites
  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.retailer_id = params[:retailer_id]
    if Favorite.is_favorite(params[:retailer_id], params[:distributor_id]) > 0
      render json: {msg: "Favorite already exists"}, status: :unprocessable_entity
    else
      if @favorite.save
        render json: @favorite, root: "data", each_serializer: FavoriteSerializer , render_attribute: params[:select_favorite] || "all"      
      else
        render json: @favorite.errors, status: :unprocessable_entity
      end
    end    
  end

  # PATCH/PUT /favorites/1
  def update
    if @favorite.update(favorite_params)
      render json: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorites/1
  def destroy
    @favorite.destroy
  end

  def is_favorite
    if Favorite.is_favorite(params[:retailer_id], params[:distributor_id]) > 0
      render json: {msg: "true"}
    else
      render json: {msg: "false"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def favorite_params
      params.require(:favorite).permit(:distributor_id, :retailer_id)
    end
end
