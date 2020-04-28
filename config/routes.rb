Rails.application.routes.draw do
 	resources :users, only: [:new, :create, :show, :edit, :update]
  root to: "blogs#index"
  resources :blogs
  resources :sessions, only: [:new, :create, :destroy]