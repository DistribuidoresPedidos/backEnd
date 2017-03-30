class AddIndexToPlaces < ActiveRecord::Migration
  def up
    add_earthdistance_index :places
  end

  def down
    remove_earthdistance_index :places
  end
end