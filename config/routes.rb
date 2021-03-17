Rails.application.routes.draw do
  resources :trend_data
  resources :trends
  resources :locations
  resources :contacts
  resources :listings
  devise_for :users
  resources :parts
  resources :manufacturers
  resources :categories
  root 'home#home', as: 'home_index'
end
