Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users_vehicles, only: %w[create]

      resources :users, only: %w[index show create] do
        resources :tickets, only: %w[index]
        resources :vehicles, only: %w[index show create]
      end

      resources :map_markers, only: %w[index create]
      resources :tickets, only: %w[create]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
