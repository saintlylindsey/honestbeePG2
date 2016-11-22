class CreateInstructions < ActiveRecord::Migration[5.0]
  def change
    create_table :instructions do |t|
      t.string :step
      t.integer :recipe_id

      t.timestamps
    end
    add_index :instructions, :recipe_id
  end
end
