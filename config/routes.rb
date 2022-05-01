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

  # Pokemon renter bookings (Custom routes)
  get '/my-bookings', to: 'pages#my_bookings', as: :my_bookings
  get '/my-bookings/:id', to: 'pages#show', as: :my_booking
  # delete '/my-bookings/:id', to: 'bookings#destroy'

  # Owner bookings (Custom routes)
  get '/owner-bookings', to: 'pages#owner_bookings', as: :owner_bookings
  get '/owner-bookings/:id', to: 'pages#owner_booking', as: :owner_booking
  patch '/owner-bookings/:id/set-status', to: 'pages#set_status'
end
