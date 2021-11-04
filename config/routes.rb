Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "main#dashboard", as: "dashboard"
  get 'calendar', to: 'bookings#calendar', as: "calendar"
  get 'configuration', to: 'main#configuration', as: "configuration"

  resources :consulting_rooms, except: [:show]
  resources :consulting_rooms, only: [:index, :new] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :show] do
    resources :records, only: [:new, :create]
  end
  resources :records, only: [:index, :show]
  resources :pets
end
