class AddHbColToIngredients < ActiveRecord::Migration[5.0]
  def change
  	add_column :ingredients, :hb, :boolean
  end
end
