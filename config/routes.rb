Rails.application.routes.draw do
  resources :user_privacies
  resources :discoveries do
    collection { get :events }
  end
  devise_for :users
  root 'home#home', as: 'home_index'

  get '/about' => 'about#index', as: 'about_page'
  get '/feed' => 'feed#index', as: 'feed_page'
end
