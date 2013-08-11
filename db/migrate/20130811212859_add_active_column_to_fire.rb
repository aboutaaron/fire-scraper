class AddActiveColumnToFire < ActiveRecord::Migration
  def change
  	add :fires, :active, :boolean
  end
end
