class CreateUserBadges < ActiveRecord::Migration[7.2]
  def change
    create_table :user_badges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true
      t.datetime :awarded_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }  # バッジを獲得した時刻を記録
      t.timestamps
    end
    add_index :user_badges, [ :user_id, :badge_id ], unique: true  # ユニーク制約で、同じユーザーに同じバッジが重複しないように設定。
  end
end
