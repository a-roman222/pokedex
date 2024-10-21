class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      redirect_to not_found_path
  end
end
