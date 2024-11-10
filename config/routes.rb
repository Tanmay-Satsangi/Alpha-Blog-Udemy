Rails.application.routes.draw do
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :articles, only: [:show, :index, :new, :create]
end
