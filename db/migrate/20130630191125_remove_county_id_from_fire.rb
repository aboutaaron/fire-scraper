class RemoveCountyIdFromFire < ActiveRecord::Migration
  def change
    remove_column :fires, :county_id
  end
end
