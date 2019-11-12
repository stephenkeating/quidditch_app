Rails.application.routes.draw do
  resources :turns
  resources :games
  resources :houses
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
