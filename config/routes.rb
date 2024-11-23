Rails.application.routes.draw do
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root 'pages#home'
  get 'about', to: 'pages#about'

  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy] #destroy is route for the delete.
  # Above code statement have same meaning as below code statement.
  resources :articles
  get 'signup', to: "users#new"

  resources :users, except: [:new]
end
