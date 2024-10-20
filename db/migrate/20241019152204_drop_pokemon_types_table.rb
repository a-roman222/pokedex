class DropPokemonTypesTable < ActiveRecord::Migration[7.2]
  def change
    drop_table :pokemon_types if table_exists?(:pokemon_types)
  end
end
