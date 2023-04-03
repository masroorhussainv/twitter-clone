Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  resources :tweets, only: %i(create) do
    resources :likes, only: %i(create destroy)
    resources :bookmarks, only: %i(create destroy)
  end

  get :dashboard, to: 'dashboard#index'
  resources :usernames, only: %i(new update)
end
