require "csv"

namespace :import do
  desc "Import pokemons from a CSV"
  task pokemons: :environment do
    file_path = Rails.root.join("lib", "pokemons.csv")

    CSV.foreach(file_path, headers: true) do |row|
      Pokemon.create!(
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
        generation: row["generation"],
        is_legendary: row["is_legendary"]
      )
    end

    puts "Pokemons imported."
  end
end
