# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# どうやらrenderでjobsが有料枠になっていそうなので、今後要検討。
# 出力先ログ
set :output, "log/cron.log"
# 環境
set :environment, "production"

# 毎日深夜3時に実行されるよう設定
every 1.day, at: "3:00 am" do
  rake "badges:assign_all"
end
