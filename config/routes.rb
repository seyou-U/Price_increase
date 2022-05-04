Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'search',to: 'products#search'
  get 'keisan',to: 'products#keisan'
  get 'keisan_select',to: 'products#keisan_select'
  get 'product_keisan',to: 'products#product_keisan'
  resources :products, only: [:index, :show]
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
end
