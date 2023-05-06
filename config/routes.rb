Rails.application.routes.draw do
  devise_for :users
  resources :likes
  resources :tweets
  #resources :users

  root "tweets#index"
  post "/auth/github", as: :github_login
  get "/auth/github/callback", to: "session#create"
  get "/profile", to: "users#show", as: "users"
end
