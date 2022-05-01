class BookingsController < ApplicationController
  before_action :find_pokemon, only: [ :new, :create ]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.pokemon = @pokemon
    if @booking.save
      redirect_to pokemon_path(@pokemon)
    else
      redirect_to pokemon_path(@pokemon)
    end
  end

  # def destroy
  #   @booking = Booking.find(params[:id])
  #   @booking.destroy
  #   redirect_to pokemon_path(@bookings)
  # end

  private

  def find_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
