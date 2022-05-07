class PokemonReviewsController < ApplicationController
  before_action :find_booking, only: [:new, :create]

  def new
    @pokemon_review = PokemonReview.new
  end

  def create
    @pokemon_review = PokemonReview.new(pokemon_review_params)
    @pokemon_review.user_id = current_user.id
    @pokemon_review.booking_id = @booking.id
    if @pokemon_review.save
      redirect_to pokemon_path(@booking.pokemon)
    else
      redirect_to my_bookings_history_path
    end
  end

  private

  def find_booking
    @booking = Booking.find(params[:booking_id])
  end

  def pokemon_review_params
    params.require(:pokemon_review).permit(:content, :rating)
  end
end
