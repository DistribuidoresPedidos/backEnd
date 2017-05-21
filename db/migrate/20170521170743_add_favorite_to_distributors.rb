class AddFavoriteToDistributors < ActiveRecord::Migration[5.0]
  def change
    add_column :distributors, :favorite, :boolean
  end
end
