class CreateOfferedProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :offered_products do |t|
      t.float :price, :null=> false 
      t.references :product, foreign_key: true
      t.references :distributor, foreign_key: true

      t.timestamps
    end
  end
end
