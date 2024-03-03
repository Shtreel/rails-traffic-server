Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users_vehicles, only: %w[create] do
        post :invite, on: :collection
      end

      resources :users, only: %w[index show create] do
        resources :tickets, only: %w[index] do
          put :dispute, on: :member
          put :dispute_result, on: :member
          get :payment_intent, on: :member
        end

        put :push_token, on: :member
        resources :payments, only: %w[index]
        resources :vehicles, only: %w[index show create]
      end

      resources :map_markers, only: %w[index create]
      resources :tickets, only: %w[create]
      resources :stripe, only: %w[] do
        post :webhook, on: :collection
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
