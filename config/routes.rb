Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'search',to: 'products#search'
  resources :products, only: [:index, :show]
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
end
