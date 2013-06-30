class AddCountyIdToFires < ActiveRecord::Migration
  def change
    add_column :fires, :county_id, :integer
  end
end
