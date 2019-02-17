class UsersController < ApplicationController
  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:likes, :comments)
    @bookmarks = Bookmark.where(user: @user).includes(:post) if @user == current_user
  end
end
