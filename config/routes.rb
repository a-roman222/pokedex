Rails.application.routes.draw do
  root "pokemons#index"
  resources :pokemons

  get "not_found", to: "pages#not_found"

  get "/pokedex", to: "pokedex#index"
  get "about", to: "pages#about"

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
