class AddLineNotifyToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :line_user_id, :string
    add_column :users, :line_notify_enabled, :boolean, default: true # LINEリマインド通知の　ON/OFF切り替えできるように。
  end
end
