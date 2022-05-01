class BookingsController < ApplicationController
  before_action :find_pokemon, only: [ :new, :create ]
  before_action :find_booking, only: [:show, :edit, :update]

  def index
    @bookings = Booking.all
  end

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

  def show; end

  def edit; end

  def update
    @booking.update(booking_params)

    redirect_to booking_path(@booking)
  end

  # def destroy
  #   @booking = Booking.find(params[:id])
  #   @booking.destroy
  #   redirect_to pokemon_path(@bookings)
  # end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
