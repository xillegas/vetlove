Rails.application.routes.draw do
  resources :consulting_rooms, only: [:index, :new] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:index, :show]
  get 'calendar', to: 'bookings#calendar'

  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'main#dashboard', as: 'dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :consulting_rooms, except: [:show]
  resources :pets
  resources :records
end
