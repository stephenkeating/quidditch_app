Rails.application.routes.draw do
  resources :games do 
    resources :turns
  end
  resources :houses
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
