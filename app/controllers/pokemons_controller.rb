class PokemonsController < ApplicationController
  def index
    @types = Type.all
    @generations = Generation.all

    if params[:search].present?
      @pokemons = Pokemon.where("name LIKE ?", "%#{params[:search]}%").page(params[:page]).per(20)
    elsif params[:type_id].present?
      @pokemons = Pokemon.joins(:types).where(types: { id: params[:type_id] }).page(params[:page]).per(20)
    elsif params[:generation_id].present?
      @pokemons = Pokemon.where(generation_id: params[:generation_id]).page(params[:page]).per(20)
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
