class ChangeVisitorNullOnNotifications < ActiveRecord::Migration[7.2]
  def change
    change_column_null :notifications, :visitor_id, true
  end
end
