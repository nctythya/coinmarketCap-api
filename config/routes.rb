Rails.application.routes.draw do
  devise_for :users
  get "about", to: "home#about"
  get "lookup", to: "home#lookup"
  post "lookup", to: "home#lookup"
  root to: "home#index"
  #root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
