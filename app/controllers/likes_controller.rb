class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      respond_to :js
    else
      flash[:alert] = 'Error saving like'
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:id], user: current_user)
    @post = @like.post
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = 'Error deleting like'
    end
  end

  private

  def like_params
    params.permit(:post_id)
  end
end
