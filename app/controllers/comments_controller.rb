class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /reports/1/comments
  def index
    @comments = @commentable.comments
  end

  # GET /reports/1/comments/1
  def show
  end

  # GET /reports/1/comments/new
  def new
    @comment = @commentable.comments.build
  end

  # GET /reports/1/comments/1/edit
  def edit
  end

  # POST /reports/1/comments
  def create
    @comment = @commentable.comments.new(comment_params)

    if @comment.save
      redirect_to [@commentable, @comment], notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reports/1/comments/1
  def update
    if @comment.update(comment_params)
      redirect_to [@commentable, @comment], notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /reports/1/comments/1
  def destroy
    @comment.destroy
    redirect_to [@commentable, :comments], notice: "Comment was successfully destroyed."
  end

  private
    def set_report
      resource, id = request.path.split('/')[1,2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
