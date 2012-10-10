class AddLocationFieldToFires < ActiveRecord::Migration
  def change
    add_column :fires, :location, :string
  end
end
