Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pokemons, only: [ :index, :show, :new, :create ] do
    resources :bookings, only: [ :new, :create ]
  end
  resources :bookings, only: [] do
    resources :pokemon_reviews, only: [ :new, :create ]
  end
  resources :users, only: [] do
    resources :bookings, only: [ :index, :show ]
    resources :pokemons, only: [ :index, :show ]
  end
end
