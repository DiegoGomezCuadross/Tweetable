Rails.application.routes.draw do
  resources :tweets
  resources :users

  post "/auth/github", as: :github_login
  get "/auth/github/callback", to: "session#create"
end
