class PostsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
  end
  
  def new
    @countries = ISO3166::Country.all_translated('JA')
  end

  def create
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
