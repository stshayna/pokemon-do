class PokemonsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_pokemon, only: [:show, :edit, :update]


  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find([params[:id]])
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

  def show; end

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
    params.require(:pokemon).permit(:name, :description, :location, :price)
  end


end
