class DashboardController < ApplicationController
  # ログインしていない人を弾いて、ログイン画面に飛ばす
  before_action :authenticate_user!

  def index
    @week_start = Date.current.beginning_of_week(:monday) # 月曜開始
    @week_dates = (@week_start..(@week_start + 6.days)).to_a # 月曜＋6日を配列に変換(1週間分)

    # ログイン中のユーザーの習慣を取得
    @habits = current_user.habits.order(created_at: :desc)
    # habitchecksテーブルから、今週のユーザーの習慣を取得
    checks = HabitCheck.where(user: current_user, checked_on: @week_dates, habit_id: @habits.pluck(:id))
    # 習慣(:habit_id)ごとにグループ化
    @checks_by_habit = checks.group_by(&:habit_id)

    # 習慣ごとの達成率をdoで回して、ダッシュボード表示
    @habits.each do |habit|
      habit.achievement_rate(current_user, @week_start)
    end
  end
end
