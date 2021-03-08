Rails.application.routes.draw do
  resources :contacts
  resources :listings
  devise_for :users
  resources :parts
  resources :manufacturers
  resources :categories
  root 'home#home', as: 'home_index'
end
