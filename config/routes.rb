Rails.application.routes.draw do
  devise_for :users
  root "posts#index"

  resources :posts do
    collection do
      get 'search'
    end
  end

  post '/posts/:post_id/likes' => "likes#create"
  delete '/posts/:post_id/likes' => "likes#destroy"

  resources :users, only: [:show]
end
