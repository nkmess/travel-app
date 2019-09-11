class UsersController < ApplicationController

  def show
    @name = current_user.name
    @posts = Post.order("created_at DESC").page(params[:page]).per(6)
    @liked_posts = current_user.liked_posts.page(params[:page]).per(6)
  end
end
