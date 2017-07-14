Rails.application.routes.draw do
  get "/hello", to: "application#hello"
  root "application#hello"
end
