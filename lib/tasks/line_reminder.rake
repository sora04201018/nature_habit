# LINEリマインドタスク
namespace :line_reminder do
  desc "Send LINE reminder messages"
  task send: :environment do
    LineReminderSender.call
  end
end
