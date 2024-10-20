class RenameOldColumnAbilitiesToAblity < ActiveRecord::Migration[7.2]
  def change
    rename_column :pokemon_abilities, :abilities_id, :ability_id
  end
end
