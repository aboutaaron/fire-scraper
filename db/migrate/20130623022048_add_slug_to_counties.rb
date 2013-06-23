class AddSlugToCounties < ActiveRecord::Migration
  def change
    add_column :counties, :slug, :string
    add_index :counties, :slug, unique: true
  end
end
