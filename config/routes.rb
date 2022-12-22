Rails.application.routes.draw do
  devise_for :users
  get "about", to: "home#about"
  get "welcome", to: "home#index"
  get "lookup", to: "home#lookup"
  post "lookup", to: "home#lookup"
  root to: "pages#home"
  #root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
