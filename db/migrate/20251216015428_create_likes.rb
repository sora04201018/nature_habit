class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
    end
    add_index :likes, [ :user_id, :likeable_type, :likeable_id ], unique: true # DB側でもユーザ１人が一つの習慣・投稿につき1回のみいいね可能
  end
end
