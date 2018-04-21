Rails.application.routes.draw do
  root "posts#index"

  get "/category/:name" => "posts#category", as: "post_category"

  get "search", to: "posts#search"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/signup" => "users#new", as: "signup"
  get "/user/settings" => "users#settings", as: "user_settings"
  resources :users, only: [:create, :update, :destroy]

  get "/profile/:name" => "users#show", as: "profile"

  resources :withdrawals, only: [:create, :update]

  resources :charges, only: [:create]
  resources :nano_payments, only: [:create]

  scope "/dashboard", as: "dashboard" do
    resources :downloads, only: [:index], module: "dashboard", as: "downloads"
    resources :earnings, only: [:index], module: "dashboard", as: "earnings"
    resources :projects, only: [:index], module: "dashboard", as: "projects"
  end

  scope "/admin", as: "admin" do
    resources :users, only: [:index, :show], module: "admin", as: "users"
    resources :posts, only: [:index, :show], module: "admin", as: "posts"
    resources :orders, only: [:index], module: "admin", as: "orders"
    resources :withdrawals, only: [:index], as: "withdrawals"
    resources :seller_requests, only: [:index], module: "admin", as: "seller_requests"
  end

  get "/p/:nice_url" => "posts#show", as: "post"
  get "/p/:nice_url/edit" => "posts#edit", as: "edit_post"
  patch "/p/:id" => "posts#update"
  get "/p/:nice_url/preview" => "posts#preview", as: "post_preview"

  resources :posts
  get "/all" => "posts#overview", as: "posts_overview"

  resources :declined_posts, only: [:create]

  resources :seller_requests, only: [:create, :new]

  resources :password_resets, only: [:create, :new]
  get "/password_reset/:reset_id" => "password_resets#show", as: "password_reset"
end
