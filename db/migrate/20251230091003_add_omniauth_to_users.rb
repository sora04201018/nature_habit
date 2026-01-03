class AddOmniauthToUsers < ActiveRecord::Migration[7.2]
  # SNS認証を実装するために、usersテーブルにカラムを追加。
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_index :users, [ :provider, :uid ], unique: true
  end
end
