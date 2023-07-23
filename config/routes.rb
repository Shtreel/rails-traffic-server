Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tickets, only: %w[index show create]
      resources :vehicles, only: %w[index show create]
      resources :users, only: %w[index show create]
      resources :users_vehicles, only: %w[index create]
      get "users_vehicles/:user_id/:vehicle_id" => "users_vehicles#show", as: "user_vehicle"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
