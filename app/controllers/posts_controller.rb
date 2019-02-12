require 'faker'

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.all.limit(10).order(created_at: 'desc').includes(:user, :likes)
    @my_likes = Like.where(user: current_user).pluck(:post_id)
    @my_bookmarks = Bookmark.where(user: current_user).includes(:post)
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.photo = params[:photo]
    if @post.save
      flash[:notice] = 'Post has been saved!'
    else
      flash[:alert] = 'Unable to save'
    end

    redirect_to posts_path
  end

  def show
    @likes = @post.likes.includes(:user)
    @my_likes = Like.where(user: current_user).pluck(:post_id)
    @bookmark = Bookmark.find_by(user: current_user, post: @post)
  end

  def destroy
    authorize @post
    if @post.destroy
      flash[:notice] = 'Post has been deleted'
    else
      flash[:alert] = 'This action is not authorized'
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :photo)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
