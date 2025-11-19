class HabitsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ
  before_action :set_habits, only: %i[ show edit update destroy ]

  def index
    @habits = current_user.habits.order(created_at: :desc)
  end

  def new
    @habit = current_user.habits.build
  end

  def show; end

  def edit; end

  def update
    if @habit.update(habit_params)
      redirect_to habit_path, notice: "習慣を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @habit = current_user.habits.build(habit_params)
    if @habit.save
      redirect_to dashboard_path, notice: "習慣を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.destroy!
    redirect_to habits_path, notice: "習慣を削除しました", status: :see_other
  end

  private

  def habit_params
    params.require(:habit).permit(:title, :frequency, :start_date)
  end

  def set_habits
    @habit = current_user.habits.find_by(id: params[:id]) # 他のユーザーがアクセスできないようcurrent_userで取り出す。
  end
end
