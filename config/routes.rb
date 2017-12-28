Rails.application.routes.draw do
  root "posts#index"

  get "/category/:name" => "posts#category", as: "post_category"

  get "search", to: "posts#search"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/signup" => "users#new", as: "signup"
  resources :users, only: [:create, :update]

  get "/profile/:name" => "users#show", as: "profile"

  get "/cart" => "carts#index"

  get "/dashboard" => "dashboard#index", as: "dashboard"
  namespace :dashboard do
    get :downloads
    get :earnings
    get :projects
  end

  scope "/admin", as: "admin" do
    resources :users, only: [:index, :show], module: "admin", as: "users"
    resources :posts, only: [:index], module: "admin", as: "posts"
    resources :orders, only: [:index], module: "admin", as: "orders"
    resources :widthdrawls, only: [:index], module: "admin", as: "widthdrawls"
    resources :seller_requests, only: [:index], module: "admin", as: "seller_requests"
  end
  get "/admin/posts/:parent_id" => "admin#parent_posts", as: "admin_parent_posts"

  get "/p/:nice_url" => "posts#show", as: "post"
  get "/p/:nice_url/edit" => "posts#edit", as: "edit_post"
  patch "/p/:id" => "posts#update"
  get "/p/:nice_url/preview" => "posts#preview", as: "post_preview"

  resources :posts
  get "/all" => "posts#overview", as: "posts_overview"

  resources :seller_requests, only: [:create, :new]

  resources :password_resets, only: [:create, :new]
  get "/password_reset/:reset_id" => "password_resets#show", as: "password_reset"

  resources :cart_posts, :charges, :orders, :widthdrawls
end
