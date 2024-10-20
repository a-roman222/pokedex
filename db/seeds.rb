require "csv"

PokemonType.destroy_all
Type.destroy_all
Ability.destroy_all
Generation.destroy_all
Pokemon.destroy_all

# Reiniciar el contador de IDs
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='types';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='pokemons';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='abilities';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='generations';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='pokemon_types';")

file_path = Rails.root.join("lib", "generations.csv")

  CSV.foreach(file_path, headers: true) do |row|
    Generation.create!(
      g_number: row["g_number"],
      g_name: row["g_name"]
    )
  end

  puts "Generation imported."

file_path = Rails.root.join("lib", "abilities.csv")

  CSV.foreach(file_path, headers: true) do |row|
    Ability.create!(
      name: row["name"]
    )
  end

  puts "Abilities imported."

file_path = Rails.root.join("lib", "types.csv")

  CSV.foreach(file_path, headers: true) do |row|
    Type.create!(
      name: row["name"]
    )
  end

  puts "Types imported."

file_path = Rails.root.join("lib", "pokemons.csv")

CSV.foreach(file_path, headers: true) do |row|
  gen = Generation.find_by(id: row["generation_id"])
  if gen&.valid?
    pp = Pokemon.create!(
        pokedex: row["pokedex"],
        name: row["name"],
        url_img: row["url_img"],
        weight_kg: row["weight_kg"],
        hp: row["hp"],
        attack: row["attack"],
        defense: row["defense"],
        sp_attack: row["sp_attack"],
        sp_defense: row["sp_defense"],
        speed: row["speed"],
        generation: gen,
        is_legendary: row["is_legendary"]
      )
    unless pp&.valid?
      puts "Invalid pokemon #{row['pokedex']}"
      next
    end
  end
end

  puts "Created #{Generation.count} Generations"
  puts "Created #{Pokemon.count} Pokemons"
  puts "Created #{Type.count} Types"
