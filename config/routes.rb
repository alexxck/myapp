Rails.application.routes.draw do
  root 'posts#index' # set start page localhost:3000
  get 'posts', to: "posts#index"
  resources :posts
  resources :authors
  #get 'authors/first_name:string'
  #get 'authors/last_name:string'
  #get 'authors/gender:string'
  #get 'authors/birthday:date'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
