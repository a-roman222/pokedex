require "csv"

namespace :import do
  desc "Import types of pokemons from  a CSV"
  task abilities: :environment do
    file_path = Rails.root.join("lib", "abilities.csv")

    CSV.foreach(file_path, headers: true) do |row|
      Ability.create!(
        name: row["name"]
      )
    end

    puts "Abilities imported."
  end
end
