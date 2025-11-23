class CreateHabitChecks < ActiveRecord::Migration[7.2]
  def change
    create_table :habit_checks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :habit, null: false, foreign_key: true
      t.date :checked_on, null: false

      t.timestamps
    end
    # 同じ習慣を同じ日に1回だけしか登録できないようにする。３つセットでユニーク制約。
    add_index :habit_checks, [:user_id, :habit_id, :checked_on], unique: true, name: "index_habit_checks_on_user_habit_date"
  end
end
