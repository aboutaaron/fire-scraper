class AddContainmentColumn < ActiveRecord::Migration
  def up
    add_column :fires, :containment, :integer
  end

  def down
  end
end
