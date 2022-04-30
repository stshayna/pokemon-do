class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def my_bookings # who's pokemon am I renting
    @my_bookings = current_user.bookings
  end

  def owner_bookings # who's rented Pokemon I own
    # puts current_user.pokemons.bookings
    @pokemons_i_rent = Pokemon.joins(:bookings).where(bookings: { user_id: current_user.id })
    @booking_requests_received = Booking.joins(:pokemons).where(pokemons: { user_id: current_user.id })
    # render "bookings"
  end

  def my_pokemons
    @owner_bookings = current_user.pokemons # all the pokemon i own
  end

end
