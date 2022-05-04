Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Pokemon owners (Custom routes)
  get '/my-pokemons', to: 'pages#my_pokemons', as: :my_pokemons

  # See my booking status as an owner & renter
  get '/my-bookings-history', to: 'pages#my_bookings_history'

  # As an owner, I can change booking status to accept or reject
  patch '/bookings/:id/accept', to: 'bookings#accept', as: :booking_accept
  patch '/bookings/:id/reject', to: 'bookings#reject', as: :booking_reject

  resources :pokemons, only: [ :index, :show, :new, :create, :edit, :update ] do
    # we need to nest our bookings inside pokemon
    resources :bookings, only: [ :show, :new, :create ]
  end

  resources :bookings do
    resources :pokemon_reviews, only: [ :new, :create ]
  end

  resources :bookings, only: [:index, :edit, :update]
end
