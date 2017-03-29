class AddCalificationToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :calification, :integer , :null=> false 
  end
end
