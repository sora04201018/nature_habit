class HabitChecksController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ
  before_action :set_habit # どのhabit_idに対するアクセスかを受け取る
  before_action :set_week_dates

  def create
    @week_start = Date.current.beginning_of_week(:monday)
    # クエリパラメーターで[:checked_on]を取得→三項演算子で条件分岐
    date = params[:checked_on].present? ? Date.parse(params[:checked_on]) : Date.current
    @habit_check = @habit.habit_checks.build(user: current_user, checked_on: date)

    if @habit_check.save

      set_checks_by_habit # その習慣の最新の１週間分のhabit_checks情報を取ってきて表示

      # turbo_stream(非同期)と同期処理のレスポンス
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "完了を記録しました" }
        format.html { redirect_back fallback_location: dashboard_path, notice: "完了を記録しました" }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :error }
        format.html { redirect_back fallback_location: dashboard_path, alert: "記録に失敗しました" }
      end
    end
  end


  def destroy
    @week_start = Date.current.beginning_of_week(:monday)
    @habit_check = @habit.habit_checks.find(params[:id])
    @habit_check.destroy

    set_checks_by_habit # その習慣の最新の１週間分のhabit_checks情報を持ってきて表示

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "完了を取り消しました" }
      format.html { redirect_back fallback_location: dashboard_path, notice: "完了を取り消しました" }
    end
  end

  private

  def set_habit
    @habit = Habit.find_by!(uuid: params[:habit_id])
  end

  def set_week_dates
    start_date = Date.current.beginning_of_week(:monday) # 月曜日スタート
    @week_dates = (start_date..(start_date + 6.days)).to_a # 月曜 + 6日を配列に変換して格納
  end

  # ユーザーがその習慣をその週にチェックしたレコードを取り出す。
  def set_checks_by_habit
    checks = HabitCheck.where(user: current_user, habit_id: @habit.id, checked_on: @week_dates)
    @checks_by_habit = { @habit.id => checks }
  end
end
