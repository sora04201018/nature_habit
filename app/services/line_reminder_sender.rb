class LineReminderSender
  def self.call(date = Date.current)
    users = User.where(
      line_notify_enabled: true
    ).where.not(line_user_id: nil)

    users.find_each do |user|
      checker = LineReminderChecker.new(user, date)

      next unless checker.remind_needed?

      LineMessageSender.send_message(
        user.line_user_id,
        reminder_message(user)
      )
    end
  end

  def self.reminder_message(user)
    "🌱 NatureHabit リマインド 今日はまだ記録されていない習慣があります。少し記録してみませんか？"
  end
end
