class AddDescriptionToCocktails < ActiveRecord::Migration[6.1]
  def change
    add_column :cocktails, :description, :text
  end
end
