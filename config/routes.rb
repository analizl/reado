Rails.application.routes.draw do
  devise_for :users
  root "books#index"

  resources :books, only: [:index, :show]
  resources :authors, only: [:show]
end
