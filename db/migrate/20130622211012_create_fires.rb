class CreateFires < ActiveRecord::Migration
  def change
    create_table :fires do |t|
      t.string :County

      t.timestamps
    end
  end
end
