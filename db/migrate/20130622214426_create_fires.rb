class CreateFires < ActiveRecord::Migration
  def change
    create_table :fires do |t|
      t.integer :acreage
      t.datetime :date
      t.integer :county_id
      t.string :name
      t.string :containment
      t.string :location

      t.timestamps
    end
  end
end
