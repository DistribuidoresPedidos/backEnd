class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :title, :null=>false
      t.text :content, :null=>false
      t.date :dateComment
      t.integer :calification
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
