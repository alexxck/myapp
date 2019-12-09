# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'posts#index' # set start page localhost:3000
  get 'posts', to: 'posts#index'
  resources :posts do
    resources :comments do
      member do
        put 'like', to: 'comments#vote'
        put 'unlike', to: 'comments#downvote'
      end
    end
  end
  resources :authors
  resources :sessions, only: %i[new create destroy]
  get '/signup', to: 'authors#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/:token/confirm_email/', :to => "authors#confirm_email", as: 'confirm_email'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
