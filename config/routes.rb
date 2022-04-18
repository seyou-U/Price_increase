Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'products/index'
  get 'products/show'
  get 'search',to: 'products#search'
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
end
