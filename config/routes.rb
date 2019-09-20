Rails.application.routes.draw do
  devise_for :users
  root 'home#top'

  resources :posts do
    collection do
      get 'search'
      get 'area_search'
    end
  end

  get '/users/:user_id/likes' => "likes#show"
  post '/posts/:post_id/likes' => "likes#create"
  delete '/posts/:post_id/likes' => "likes#destroy"


  resources :users, only: [:show]
end
