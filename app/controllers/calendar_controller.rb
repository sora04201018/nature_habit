class CalendarController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @month = params[:month] ? Date.parse(params[:month]) : Date.current
    @habit_checks = current_user.habit_checks.includes(:habit).where(checked_on: @month.beginning_of_month..@month.end_of_month) # 今ログインしているユーザーのチェック状況・習慣情報(タイトルなど)を取得 カレンダー表示のため
  end
end
