class AddLatitudeAndLongitudeToCounty < ActiveRecord::Migration
  def change
    add_column :counties, :latitude, :float
    add_column :counties, :longitude, :float
  end
end
