Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :products, only: [:index, :show] do
    member  do
      get 'product_keisan'
    end
    collection do
      get 'keisan'
      get 'search'
    end
  end
  resources :predict_products
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
end
