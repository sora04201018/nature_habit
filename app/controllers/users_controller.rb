class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user # ユーザー情報取得

    @total_habit_checks_count = @user.total_habit_checks_count

    # ユーザー未獲得のバッジをマイページに表示
    @owned_badges = @user.badges
    @unowned_badges = Badge.where.not(id: @owned_badges.pluck(:id)) # where.notで条件に合わないものを返す。 pluck(:id)でidの配列で返す。
  end
end
