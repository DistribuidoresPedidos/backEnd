class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :state,  :null=>false
      t.date :exitDate
      t.date :arrivalDate
      t.float :totalPrice, :null=>false
      t.references :retailer, foreign_key: true
      t.references :route, foreign_key: true

      t.timestamps
    end
  end
end
