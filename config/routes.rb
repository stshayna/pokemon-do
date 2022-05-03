Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :pokemons, only: [ :index, :show, :new, :create, :edit, :update ] do
    # we need to nest our bookings inside pokemon
    resources :bookings, only: [ :show, :new, :create ]
  end

  resources :bookings, only: [] do
    resources :pokemon_reviews, only: [ :new, :create ]
  end

  resources :bookings, only: [:index, :edit, :update]

  # Pokemon owners (Custom routes)
  get '/my-pokemons', to: 'pages#my_pokemons', as: :my_pokemons

  # See my booking status as an owner & renter
  get '/my-bookings-history', to: 'pages#my_bookings_history'
end
