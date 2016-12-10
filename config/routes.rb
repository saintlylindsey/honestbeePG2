Rails.application.routes.draw do
	devise_for :users, :controllers => { :registrations => "users/registrations" }
#  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: "welcome#index"
  resources :recipes
  root "recipes#index"
  get 'search_recipes', to: "recipes#search"
  resources :categories
  resources :ingredients
end
