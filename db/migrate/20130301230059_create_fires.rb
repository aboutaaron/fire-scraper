class CreateFires < ActiveRecord::Migration
  def change
    create_table :fires do |t|
      t.string :name
      t.integer :acreage
      t.string :date
      t.float :containment
      t.string :location

      t.timestamps
    end
  end
end
