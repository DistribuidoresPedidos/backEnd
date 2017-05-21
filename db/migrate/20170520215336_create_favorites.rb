class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.references :distributor, foreign_key: true
      t.references :retailer, foreign_key: true

      t.timestamps
    end
  end
end
