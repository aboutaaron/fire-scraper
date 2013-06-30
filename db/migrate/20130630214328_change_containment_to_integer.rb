class ChangeContainmentToInteger < ActiveRecord::Migration
  def up
  	change_column :fires, :containment, :integer
  end

  def down
  	change_column :fires, :containment, :string
  end
end
