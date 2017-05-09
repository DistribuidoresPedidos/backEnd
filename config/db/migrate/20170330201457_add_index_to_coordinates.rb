class AddIndexToCoordinates < ActiveRecord::Migration[5.0]
  def up
    add_earthdistance_index :coordinates
  end

  def down
    remove_earthdistance_index :coordinates
  end
end
