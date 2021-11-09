Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "main#dashboard", as: "dashboard"
  get 'configuration', to: 'main#configuration', as: "configuration"
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  get "consulting_rooms_vet", to: "consulting_rooms#index_vet"
  get "consulting_rooms_user", to: "consulting_rooms#index_user"

  resources :consulting_rooms, except: [:show]
  resources :consulting_rooms, only: [:index, :new] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :show] do
    resources :records, only: [:new, :create]
  end
  resources :records, only: [:index, :show]
  resources :pets, except: [:show]
end
