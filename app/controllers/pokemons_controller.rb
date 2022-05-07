class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_pokemon, only: [:show, :edit, :update]

  def index
    if params[:query].present?
      @pokemons = Pokemon.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @pokemons = Pokemon.all.order(id: :desc)
    end
  end

  def show
    @booking = Booking.new
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    @pokemon.image_url = "https://img.pokemondb.net/artwork/large/#{@pokemon.species.downcase}.jpg"
    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :new
    end
  end

  def edit; end

  def update
    @pokemon.update(pokemon_params)

    redirect_to pokemon_path(@pokemon)
  end

  # add edit, update and destroy

  private

  def find_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :species, :description, :location, :price, :image_url)
  end


end
