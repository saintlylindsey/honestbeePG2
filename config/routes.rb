Rails.application.routes.draw do

  namespace :api, :defaults => {:format => :json} do
    resources :recipes
  end

  devise_for :users, :controllers => { 
    :registrations => "users/registrations",
    :sessions => "sessions"
  }

  as :user do
    post 'sign_in' => 'sessions#create'
    delete 'sign_out' => 'sessions#destroy'
    delete 'logout' => 'sessions#logout'
  end
  
#  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: "welcome#index"
  resources :recipes do
  	resources :reviews, except: [:show, :index]
  end
#  root "recipes#index"
  root "categories#index"
  get 'search_recipes', to: "recipes#search"
  resources :categories
  resources :ingredients
end
