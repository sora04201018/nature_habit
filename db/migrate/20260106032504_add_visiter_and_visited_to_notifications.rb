class AddVisiterAndVisitedToNotifications < ActiveRecord::Migration[7.2]
  def change
    add_reference :notifications, :visitor, null: false, foreign_key: { to_table: :users }
    add_reference :notifications, :visited, null: false, foreign_key: { to_table: :users }

    remove_reference :notifications, :user, foreign_key: true
  end
end
