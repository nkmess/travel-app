class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :search, :search_europe, :search_africa, :search_northamerica, :search_latainamerica, :search_asia, :search_oceania, :search_middleeast]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_countries, onle: [:new, :create, :edit, :update]

  def index
    @posts = Post.recent.page(params[:page]).per(6)

    @sidebarAreas = 
      [{area:"Europe", kana:"ヨーロッパ", link: "/searcharea/europe"},
      {area:"Africa", kana:"アフリカ", link: "/searcharea/africa"},
      {area:"North America", kana:"北アメリカ", link: "/searcharea/northamerica"},
      {area:"Latin America", kana:"ラテンアメリカ", link: "/searcharea/latinamerica"},
      {area:"Asia", kana:"アジア", link: "/searcharea/asia"},
      {area:"Oceania & Pacific Ocean", kana:"オセアニア＆太平洋", link: "/searcharea/oceania"},
      {area:"Middle East", kana:"中東", link: "/searcharea/middleeast"},
      {area:"All Over The World", kana:"世界各地", link: search_posts_path}]


      tour_areas = ["AAS", "BCH", "HWI", "EUR", "DUS", "FOC", "CAF"]
      @tour_area = tour_areas.sample
      uri = "http://webservice.recruit.co.jp/ab-road/tour/v1/?" + 
        "key=#{ENV['TRAVEL_APIKEY']}&" + "area=#{@tour_area}&" + "format=json"

      uri = URI.parse(uri)
      req = Net::HTTP::Get.new(uri)
      res = Net::HTTP.start(uri.host, uri.port){|http|
        http.request(req)
      }
      @tour_result = JSON.parse(res.body)
      @tour_image = @tour_result["results"]["tour"][0]["img"][0]["l"]
      @tour_link = @tour_result["results"]["tour"][0]["urls"]["pc"]
      @tour_title = @tour_result["results"]["tour"][0]["title"]
      @min_price = @tour_result["results"]["tour"][0]["price"]["min"]
      @max_price = @tour_result["results"]["tour"][0]["price"]["max"]
  end

  def show
    @country = ISO3166::Country.find_country_by_number(@post.country)
  end
  
  def new
    @post = Post.new
  end

  def create
    @post= Post.new(post_params)
      if @post.save
        flash[:notice] = "投稿が完了しました！"
        redirect_to posts_path
      else
        flash[:alert] = "投稿に失敗しました…"
        render new_post_path
      end
  end

  def edit
    if @post.user.id != current_user.id
      redirect_to posts_path
    end
  end

  def update
    if @post.user_id == current_user.id
      if @post.update(post_params)
        flash[:notice] = "更新しました"
        redirect_to controller: :posts, action: :index
      else
        flash[:alert] = "更新に失敗しました"
        render('posts/edit')
      end
    end
  end

  def destroy
    if @post.user_id == current_user.id
      if @post.destroy
        flash[:alert] = "削除しました"
        redirect_to posts_path
      else
        flash[:alert] = "削除に失敗しました"
        redirect_to post_path
      end
    end
  end

  def search
    @posts = Post.where('text LIKE(?)', "%#{params[:post]}%").recent.page(params[:page]).per(6)
  end

  def search_europe
    @posts = Post.where(country: ["208", "250", "528", "578", "643", "724", "752", "826"])
  end

  def search_africa
    @posts = Post.where(country: ["710, 818"])
  end

  def search_northamerica
    @posts = Post.where(country: ["124", "840"])
  end

  def search_latainamerica
    @posts = Post.where(country: ["032","076", "152"])
  end

  def search_asia
    @posts = Post.where(country: ["156", "158", "344", "392", "410", "702", "764"])
  end

  def search_oceania
    @posts = Post.where(country: ["036", "316",  "554"])
  end

  def search_middleeast
    @posts = Post.where(country: ["682", "792"])
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

  def set_countries
    @countries = ISO3166::Country.all
  end

end
