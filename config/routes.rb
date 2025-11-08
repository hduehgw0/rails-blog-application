Rails.application.routes.draw do
  get 'users/show'
  get 'users/following'
  get 'users/followers'
  get 'dashboard/show'
  get 'static_pages/home'
  devise_for :users
  
  # Root
  root "static_pages#home"
  
  # Static pages
  get "/dashboard", to: "dashboard#show"
  
  # Users
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end
  
  # Posts
  resources :posts
  
  # Relationships
  resources :relationships, only: [:create, :destroy]
  
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Letter opener (development only)
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
