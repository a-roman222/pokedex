require "csv"

namespace :import do
  desc "Import types of pokemons from  a CSV"
  task types: :environment do
    file_path = Rails.root.join("lib", "types.csv")

    CSV.foreach(file_path, headers: true) do |row|
      Type.create!(
        name: row["name"]
      )
    end

    puts "Types imported."
  end
end
