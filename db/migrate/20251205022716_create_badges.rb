class CreateBadges < ActiveRecord::Migration[7.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false # バッジ名
      t.text :description # バッジ説明
      t.integer :threshold, null: false   # 累計達成数でバッジ付与
      t.string :icon  # バッジアイコン

      t.timestamps
    end
    add_index :badges, :threshold # thresholdにadd_indexをつけて検索高速化
  end
end
