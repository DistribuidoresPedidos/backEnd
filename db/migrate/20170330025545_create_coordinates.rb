class CreateCoordinates < ActiveRecord::Migration[5.0]
  def change
    create_table :coordinates do |t|
      t.float :lat
      t.float :lng
      t.references :route, foreign_key: true

      t.timestamps
    end
  end
end
