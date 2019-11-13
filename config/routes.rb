Rails.application.routes.draw do
  resources :houses do
    resources :games do 
      resources :turns
    end
  end
  
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/signup", to: "users#new", as: "signup"
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
  post "/sessions/reset", to: "sessions#reset"
end
