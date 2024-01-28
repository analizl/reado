Rails.application.routes.draw do
  devise_for :users
  root "books#index"

  get "/books", to: "books#index"
end
