class ChangeActiveToFires < ActiveRecord::Migration
  def up
  	add_column :fires, :active, :boolean, default: false
  end

  def down
  	remove_column :fires, :active
  end
end
