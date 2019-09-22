Rails.application.routes.draw do
  devise_for :users
  root 'home#top'

  resources :posts do
    collection do
      get 'search'
    end
  end

  get '/users/:user_id/likes' => "likes#show"
  post '/posts/:post_id/likes' => "likes#create"
  delete '/posts/:post_id/likes' => "likes#destroy"

  get '/searcharea/europe' => 'posts#search_europe'
  get '/searcharea/africa' => 'posts#search_africa'
  get '/searcharea/northamerica' => 'posts#search_northamerica'
  get '/searcharea/latainamerica' => 'posts#search_latainamerica'
  get '/searcharea/asia' => 'posts#search_asia'
  get '/searcharea/oceania' => 'posts#search_oceania'
  get '/searcharea/middleeast' => 'posts#search_middleeast'



  resources :users, only: [:show]
end
