require "csv"

namespace :import do
  desc "Import generations data from  a CSV"
  task generations: :environment do
    file_path = Rails.root.join("lib", "generations.csv")

    CSV.foreach(file_path, headers: true) do |row|
      Generation.create!(
        g_number: row["g_number"],
        g_name: row["g_name"]
      )
    end

    puts "Generation imported."
  end
end
