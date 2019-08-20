class PostsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
  end
  
  def new
    @post = Post.new
    @countries = ISO3166::Country.all_translated('JA')
  end

  def create
    @post= Post.create(post_params)
  end

  private
  def post_params
    params.require(:post).permit(:text, :country, :duration, :image).merge(user_id: current_user.id)
  end



  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
