class PokemonsController < ApplicationController
  def index
    if params[:search].present?
      @pokemons = Pokemon.where("name LIKE ?", "%#{params[:search]}%").page(params[:page]).per(20)

      if @pokemons.empty?
        flash.now[:alert] = "No Pokémon found for '#{params[:search]}'."
      end
    else
      @pokemons = Pokemon.page(params[:page]).per(20)
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to not_found_path
  end
end
