class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy, :index]

  # GET /comments
  def index
    render json: @comments,root: "data", adapter: :json#, meta: pagination_dict(@comments)
  end

  # GET /comments/1
  def show
    @comment = @comments.comment_by_id(params[:id])
    render json: @comment,root: "data", adapter: :json
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created,root: "data", adapter: :json
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment,root: "data", adapter: :json
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comments = Comment.comments_by_order(params[:order_id], params[:page], params[:per_page])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:title, :content, :dateComment, :calification, :order_id)
    end
end
