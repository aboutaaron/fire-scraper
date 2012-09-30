class CreateFires < ActiveRecord::Migration
  def change
    create_table :fires do |t|
      t.string :name
      t.integer :acerage
      t.string :date
      t.integer :county_id

      t.timestamps
    end
  end
end
