Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#home"
  get "pages/home", to: "pages#home"

  resources :recipes do
    resources :comments, only: [:create]
  end

  get "/signup", to: "chefs#new"
  resources :chefs, except: [:new]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :ingredients, except: [:destroy]
end
