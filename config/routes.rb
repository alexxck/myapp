Rails.application.routes.draw do
  root 'posts#index' # set start page localhost:3000
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
