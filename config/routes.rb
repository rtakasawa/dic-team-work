Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destory]
end
