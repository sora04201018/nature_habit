class CreateHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :habits do |t|
      t.string :title, null: false
      t.text :description  # MVPリリース時点では使わない
      t.integer :frequency, default: 0, null: false
      t.date :start_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
