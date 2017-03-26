class CreateOrderProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :order_products do |t|
      t.float :quantity, :null=>false
      t.float :price, :null=>false
      t.references :offeredProduct, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
