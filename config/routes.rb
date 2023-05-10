Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: :callbacks
  }
  resources :likes
  resources :tweets
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  #resources :users

  root "tweets#index"

  get "/profile", to: "users#show", as: "users"
end
