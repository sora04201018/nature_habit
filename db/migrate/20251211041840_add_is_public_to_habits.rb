class AddIsPublicToHabits < ActiveRecord::Migration[7.2]
  def change
    add_column :habits, :is_public, :boolean, default: false, null: false # habitsテーブルに習慣の公開/非公開を選択できるよう追記。
  end
end
