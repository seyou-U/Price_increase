Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
end
