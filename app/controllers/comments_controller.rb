class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = @post.comments.includes(:user)
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @post = @comment.post
      respond_to :js
    else
      flash[:alert] = 'Error saving comment'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment_id = @comment.id
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = 'Error deleting comment'
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :content)
  end
end
