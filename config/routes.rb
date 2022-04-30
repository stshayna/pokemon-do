Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pokemons, only: [ :index, :show, :new, :create ] do
    resources :bookings, only: [ :new, :create ]
  end
  resources :bookings do
    resources :pokemon_reviews, only: [ :new, :create ]
  end
end
