Rails.application.routes.draw do
  get "/sign_up", to: "users#new"

  get "/hello", to: "application#hello"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  root "static_pages#home"
  resources :users
end
