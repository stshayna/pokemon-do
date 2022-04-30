class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find[params[:id]]
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.user = current_user
    if pokemon.save
      redirect_to pokemons_path
    else
      render :new
    end
  end

  # add edit, update and destroy

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :description, :location, :price)
  end


end
