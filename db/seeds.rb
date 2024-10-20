require "csv"

PokemonType.destroy_all
Type.destroy_all
Ability.destroy_all
Generation.destroy_all
Pokemon.destroy_all
PokemonAbility.destroy_all


ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='types';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='pokemons';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='abilities';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='generations';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='pokemon_types';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='pokemon_abilities';")

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

file_path = Rails.root.join("lib", "pokemon_types.csv")

  PokemonType.destroy_all

  CSV.foreach(file_path, headers: true) do |row|
    pokemon_id = row["pokemon_id"].to_i
    type_id = row["type_id"].to_i

    if Pokemon.exists?(pokemon_id) && Type.exists?(type_id)
      PokemonType.create!(
        pokemon_id: pokemon_id,
        type_id: type_id
      )
    else
      puts "Skipping row: Pokemon ID #{pokemon_id} or Type ID #{type_id} does not exist."
    end
  end

puts "pokemon types imported."

file_path = Rails.root.join("lib", "pokemon_abilities.csv")

CSV.foreach(file_path, headers: true) do |row|
  pokemon_id = row["pokemon_id"].to_i
  ability_id = row["ability_id"].to_i

  if Pokemon.exists?(pokemon_id) && Ability.exists?(ability_id)
    PokemonAbility.create!(
      pokemon_id: pokemon_id,
      ability_id: ability_id
    )
  else
    puts "Skipping row: Pokemon ID #{row['pokemon_id']} or Ability ID: #{row['ability_id']}"
  end
end

puts "PokemonAbilities imported."

puts "Created #{Generation.count} Generations"
puts "Created #{Pokemon.count} Pokemons"
puts "Created #{Type.count} Types"
puts "Created #{Ability.count} Abilities"
puts "Created #{PokemonType.count} Pokemon Types"
puts "Created #{PokemonAbility.count} Pokemon Abilities"
