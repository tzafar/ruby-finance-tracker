Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'my_portfolio', to: 'user#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  resources :user_stocks
  get 'friends', to: 'user#friends'
  get 'search_friends', to: 'user#search'
  resources :friendships, only: [:create, :destroy]
end
