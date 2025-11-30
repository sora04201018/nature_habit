class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user # ユーザー情報取得
    @month = params[:month] ? Date.parse(params[:month]) : Date.current
    @habit_checks = current_user.habit_checks.includes(:habit).where(checked_on: @month.beginning_of_month..@month.end_of_month) # 今ログインしているユーザーのチェック状況・習慣情報(タイトルなど)を取得 カレンダー表示のため
  end
end
