class DashboardController < ApplicationController
  # ログインしていない人を弾いて、ログイン画面に飛ばす
  before_action :authenticate_user!

  def index
    start_date = Date.current.beginning_of_week(:monday) # 月曜開始
    @week_dates = (start_date..(start_date + 6.days)).to_a # 月曜＋6日を配列に変換(1週間分)

    # ログイン中のユーザーの習慣を取得
    @habits = current_user.habits.order(created_at: :desc)
    # habitchecksテーブルから、今週のユーザーの習慣を取得
    checks = HabitCheck.where(user: current_user, checked_on: @week_dates, habit_id: @habits.pluck(:id))
    # 習慣(:habit_id)ごとにグループ化
    @checks_by_habit = checks.group_by(&:habit_id)
  end
end
