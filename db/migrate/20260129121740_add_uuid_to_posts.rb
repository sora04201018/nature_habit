class AddUuidToPosts < ActiveRecord::Migration[7.2]
  def change
    # Postsにuuid追加し、設定。（postgres（DB)側でランダムなuuidを生成させる。
    add_column :posts, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false

    add_index :posts, :uuid, unique: true
  end
end
