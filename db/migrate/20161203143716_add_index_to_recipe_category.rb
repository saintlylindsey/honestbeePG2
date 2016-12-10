class AddIndexToRecipeCategory < ActiveRecord::Migration[5.0]
  def change
  	add_index :recipe_categories, :recipe_id
    add_index :recipe_categories, :category_id
  end
end
