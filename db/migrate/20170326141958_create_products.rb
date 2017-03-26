class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, :null=> false 
      t.string :category, :null=> false 
      t.float :weight, :null=> false 
      t.string :photo, :null=> false 

      t.timestamps
    end
  end
end
