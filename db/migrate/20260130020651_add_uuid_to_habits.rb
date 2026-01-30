class AddUuidToHabits < ActiveRecord::Migration[7.2]
  def change
    # habitsにもuuid追加
    add_column :habits, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false

    add_index :habits, :uuid, unique: true
  end
end
