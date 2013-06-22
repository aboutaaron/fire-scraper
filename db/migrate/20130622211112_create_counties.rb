class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|

      t.timestamps
    end
  end
end
