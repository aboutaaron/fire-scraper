class CreateFires < ActiveRecord::Migration
  def change
    create_table :fires do |t|
      t.string :fire_name
      t.string :fire_county
      t.string :fire_address
      t.integer :total_acres_burned
      t.string :fire_contained
      t.string :date_fires_started
      t.string :last_date_fire_updated

      t.timestamps
    end
  end
end
