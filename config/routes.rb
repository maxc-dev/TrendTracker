Rails.application.routes.draw do
  resources :user_privacies
  resources :discoveries do
    collection { get :events }
  end
  resources :trend_data
  resources :trends
  resources :locations
  devise_for :users
  root 'home#home', as: 'home_index'
end
