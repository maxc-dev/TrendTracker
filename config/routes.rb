Rails.application.routes.draw do
  resources :discoveries do
    collection { get :events }
  end
  resources :trend_data
  resources :trends
  resources :locations
  resources :accounts
  devise_for :users
  root 'home#home', as: 'home_index'
end
