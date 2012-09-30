class ChangeContainmentToStrigngAndRenameAcreage < ActiveRecord::Migration
  def up
    rename_column :fires, :acerage, :acreage
    change_column :fires, :containment, :string
  end

  def down
    drop_column :fires, :acerage
  end
end
