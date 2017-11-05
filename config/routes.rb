Rails.application.routes.draw do
  root "posts#index"

  get "/category/:name" => "posts#category", as: "post_category"

  get "search", to: "posts#search"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/signup" => "users#new", as: "signup"
  post "/users" => "users#create"

  get "/profile/:name" => "users#show", as: "profile"

  get "/cart" => "carts#index"

  get "/dashboard" => "dashboard#index", as: "dashboard"
  namespace :dashboard do
    get :downloads
    get :earnings
    get :projects
  end

  get "/admin" => "admin#index", as: "admin"
  namespace :admin do
    get :users
    get :orders
    get :posts
    get :widthdrawls
  end

  get "/p/:nice_url" => "posts#show", as: "post"
  patch "/p/:nice_url" => "posts#update"
  get "/p/:nice_url/preview" => "posts#preview", as: "post_preview"

  resources :posts

  resources :cart_posts, :charges, :orders, :widthdrawls
end
