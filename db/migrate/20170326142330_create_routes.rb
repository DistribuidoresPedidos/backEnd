class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.string :name, :null => false
      t.references :distributor, foreign_key: true

      t.timestamps
    end
  end
end
