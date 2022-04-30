Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :pokemons, only: [ :index, :show, :new, :create ] do
    resources :bookings, only: [ :new, :create ]
  end

  resources :bookings, only: [] do
    resources :pokemon_reviews, only: [ :new, :create ]
  end

  # Pokemon owners (Custom routes)
  get '/my-pokemons', to: 'pokemons#my_pokemons', as: :my_pokemons

  # Pokemon renter bookings (Custom routes)
  get '/my-bookings', to: 'bookings#my_bookings', as: :my_bookings
  get '/my-bookings/:id', to: 'bookings#show', as: :my_booking
  delete '/my-bookings/:id', to: 'bookings#destroy'

  # Owner bookings (Custom routes)
  get '/owner-bookings', to: 'bookings#owner_bookings', as: :owner_bookings
  get '/owner-bookings/:id', to: 'bookings#owner_booking', as: :owner_booking
  patch '/owner-bookings/:id/set-status', to: 'bookings#set_status'
end
