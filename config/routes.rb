Rails.application.routes.draw do
  root to: "blogs#index"
  resources :blogs
  resources :sessions, only: [:new, :create, :destroy]
end