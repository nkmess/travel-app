class UsersController < ApplicationController

  def show
    @name = current_user.name
    @posts = Post.where(user_id: current_user.id).page(params[:page]).per(6)
  end

end
