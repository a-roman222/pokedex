class CreateGenerations < ActiveRecord::Migration[7.2]
  def change
    create_table :generations do |t|
      t.integer :g_number
      t.string :g_name
      t.belongs_to :Pokemon

      t.timestamps
    end
  end
end
