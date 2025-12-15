class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, null: false # polymorphicを使って、習慣にも投稿にもコメントできるようにする。

      t.timestamps
    end
    # 検索が速くなるインデックス
    add_index :comments, [ :commentable_type, :commentable_id ]
  end
end
