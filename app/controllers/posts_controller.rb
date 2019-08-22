class PostsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
  end
  
  def new
    @post = Post.new
    @countries = ISO3166::Country.all
  end

  def create
    @post= Post.create(post_params)
      if @post.save()
        flash[:notice] = "投稿が完了しました！"
        redirect_to root_path
      else
        flash[:alert] = "投稿に失敗しました…"
        redirect_to root_path
      end
  end

  private
  def post_params
    params.require(:post).permit(:text, :country, :duration, :image).merge(user_id: current_user.id)
  end



  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
