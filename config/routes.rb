Rails.application.routes.draw do
  resources :users

  post "/auth/github", as: :github_login
  get "/auth/github/callback", to: "session#create"
end
