class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.string :slug
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
