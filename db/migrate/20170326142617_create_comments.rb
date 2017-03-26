class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.date :dateComment
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
