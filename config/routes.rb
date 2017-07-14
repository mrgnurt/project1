Rails.application.routes.draw do
  get "/hello", to: "application#hello"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  root "application#hello"
end
