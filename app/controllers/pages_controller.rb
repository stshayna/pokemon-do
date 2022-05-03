class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def my_pokemons # all the pokemon i own
    @owner_pokemons = Pokemon.where(user: current_user)
  end

  def renter_bookings # who's pokemon am I renting
    @renter_bookings = Pokemon.all { |pokemon| pokemon.bookings.where(user: current_user) } # Still working on this!
    @my_bookings = current_user.bookings
  end

  def owner_bookings # Shows all owner pokemons who have have bookings
    @pokemons_i_rent = Pokemon.joins(:bookings).where(bookings: { user_id: current_user.id })
    @booking_requests_received = Booking.joins(:pokemons).where(pokemons: { user_id: current_user.id })
  end

  def my_bookings_history
    @bookings = {
      # From means bookings from renters to owners
      # To means bookings from owners to renters
      upcoming: {
        from: current_user.bookings.where("start_date > ?", Time.now.to_date).order(start_date: :asc),
        to: Booking.joins(pokemon: :user).where(pokemons: { user: current_user }).where("start_date > ?", Time.now.to_date).order(start_date: :asc)
      },
      present: {
        from: current_user.bookings.where("start_date <= ?", Time.now.to_date).where("end_date >= ?", Time.now.to_date).order(start_date: :asc),
        to: Booking.joins(pokemon: :user).where(pokemons: { user: current_user }).where("start_date <= ?", Time.now.to_date).where("end_date >= ?", Time.now.to_date).order(start_date: :asc)
      },
      past: {
        from: current_user.bookings.where("end_date < ?", Time.now.to_date).order(end_date: :desc),
        to: Booking.joins(pokemon: :user).where(pokemons: { user: current_user }).where("end_date < ?", Time.now.to_date).order(end_date: :desc)
      }
    }
  end
end

Pokemon.all do |pokemon|
  pokemon.bookings.where(user: current_user)
end

def find_owner_boookings
 Pokemon.all do |pokemon|
    pokemon.bookings.where(user: current_user)
  end
end
