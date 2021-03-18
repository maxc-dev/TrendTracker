Rails.application.routes.draw do
  resources :discoveries
  resources :trend_data
  resources :trends
  resources :locations
  devise_for :users
  root 'home#home', as: 'home_index'
end
