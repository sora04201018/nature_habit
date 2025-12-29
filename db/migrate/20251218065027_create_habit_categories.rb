class CreateHabitCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :habit_categories do |t|
      t.references :habit, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :habit_categories, [ :habit_id, :category_id ], unique: true
  end
end
