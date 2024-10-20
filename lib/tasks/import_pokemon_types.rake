namespace :import do
  desc "Import data from pokemon_types.csv"
  task pokemon_types: :environment do
    require "csv"

    # Cambia la ruta según donde esté tu archivo CSV
    csv_file_path = Rails.root.join("lib", "pokemon_types.csv")

    CSV.foreach(csv_file_path, headers: true) do |row|
      PokemonType.create!(
        pokemon_id: row["pokemon_id"],
        type_id: row["type_id"]
      )
    end

    puts "pokemon_types imported."
  end
end
