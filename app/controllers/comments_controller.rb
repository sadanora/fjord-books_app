class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]

  def edit
    if current_user?(@comment.user)
      render :edit
    else
      redirect_to @commentable
    end
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if current_user?(@comment.user)
      @comment.save
      redirect_to @commentable, notice: "Comment was successfully created."
    else
      render @commentable, status: :unprocessable_entity
    end
  end

  def update
    if current_user?(@comment.user)
      @comment.update(comment_params)
      redirect_to @commentable, notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user?(@comment.user)
      @comment.destroy
      redirect_to @commentable, notice: "Comment was successfully destroyed."
    else
      render @commentable, status: :unprocessable_entity
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

    def current_user?(user)
      user && user == current_user
    end
end
