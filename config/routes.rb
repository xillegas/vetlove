Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :consulting_rooms, only: [ :index, :new, :create, :edit, :update, :destroy ]
end
