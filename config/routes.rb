Rails.application.routes.draw do
  root 'home#index'
  devise_for :users 
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  resources :products, only: [:index, :show] do
    resource :favorites, only: [:create, :destroy]
    member  do
      get 'product_keisan'
    end
    collection do
      get 'keisan'
      get 'search'
    end
  end
  resources :predict_products
  resources :users, only: [:index, :edit]
  get '/users/favorite',to: 'users#show'
end
