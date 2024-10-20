class CreatePokemons < ActiveRecord::Migration[7.2]
  def change
    create_table :pokemons do |t|
      t.integer :pokedex
      t.string :name
      t.string :url_img
      t.float :weight_kg
      t.integer :hp
      t.integer :attack
      t.integer :defense
      t.integer :sp_attack
      t.integer :sp_defense
      t.integer :speed
      t.integer :generation_id
      t.boolean :is_legendary
      t.references :generation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
