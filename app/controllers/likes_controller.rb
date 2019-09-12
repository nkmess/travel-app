class LikesController < ApplicationController
  before_action :set_post, only: [:create, :destroy]

  def show
    @name = current_user.name
    @liked_posts = current_user.liked_posts.page(params[:page]).per(6)
  end

  def create
    @like = Like.create(user_id: current_user.id, post_id: @post.id)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    @like.destroy
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
