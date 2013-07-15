class CreateFires < ActiveRecord::Migration
  def change
    create_table :fires do |t|
      t.integer :acreage
      t.integer :containment
      t.integer :county_id
      t.datetime :date
      t.string :location
      t.string :name

      t.timestamps
    end
  end
end
