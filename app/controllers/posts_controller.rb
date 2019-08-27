class PostsController < ApplicationController

  before_action :move_to_index, except: :index
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(6)

    @sidebarAreas = 
      [{area:"Europe", kana:"ヨーロッパ", link:""},
      {area:"Africa", kana:"アフリカ", link:""},
      {area:"North America", kana:"北アメリカ", link:""},
      {area:"Latin America", kana:"ラテンアメリカ", link:""},
      {area:"Asia", kana:"アジア", link:""},
      {area:"Oceania & Pacific Ocean", kana:"オセアニア＆太平洋", link:""},
      {area:"Middle East", kana:"中東", link:""},
      {area:"All Over The World", kana:"世界各地", link:""}]
  end

  def show
    @country = ISO3166::Country.find_country_by_number(@post.country)
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

  def edit
    if @post.user.id != current_user.id
      redirect_to root_path
    end
    @countries = ISO3166::Country.all
  end

  def update
    if @post.user_id == current_user.id
      if @post.update(post_params)
        flash[:notice] = "更新しました"
        redirect_to controller: :posts, action: :index
      else
        flash[:notice] = "更新に失敗しました"
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:text, :country, :duration, :image).merge(user_id: current_user.id)
  end



  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end


  def set_post
    @post = Post.find(params[:id])
  end

end
