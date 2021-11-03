Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'main#dashboard', as: 'dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :consulting_rooms, except: [:show]
  resources :pets
end
