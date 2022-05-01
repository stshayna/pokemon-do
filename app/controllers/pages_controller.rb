class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def my_pokemons # all the pokemon i own
    @owner_bookings = current_user.pokemons
  end

  def my_bookings # who's pokemon am I renting
    @my_bookings = current_user.bookings
  end

  def owner_bookings # who's rented Pokemon I own
    @pokemons_i_rent = Pokemon.joins(:bookings).where(bookings: { user_id: current_user.id })
    @booking_requests_received = Booking.joins(:pokemons).where(pokemons: { user_id: current_user.id })
  end

  def set_status

  end

end
