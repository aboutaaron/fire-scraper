class AddActiveColumnToFire < ActiveRecord::Migration
  def change
  	add_column :fires, :active, :boolean, default: false, null: false
  end
end
