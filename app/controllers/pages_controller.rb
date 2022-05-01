class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def my_bookings # who's pokemon am I renting
    @my_bookings = current_user.bookings
  end

  def my_pokemons # all the pokemon i own
    @owner_bookings = current_user.pokemons
  end

  def owner_bookings # who's rented Pokemon I own
    @pokemons_i_rent = Pokemon.joins(:bookings).where(bookings: { user_id: current_user.id })
    @booking_requests_received = Booking.joins(:pokemons).where(pokemons: { user_id: current_user.id })
  end

  def set_status
    @owner_booking = Booking.find(params[:id])
    @owner_booking.update(owner_booking_params)
    redirect_to owner_bookings_path(@owner_booking)
  end

end
