class HabitsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ
  before_action :set_habits, only: %i[ edit update destroy ]

  # 習慣公開処理
  def public_index
    @habits = Habit.publicly_visible.includes(:user).order(created_at: :desc)
    @week_start = Date.current.beginning_of_week(:monday) # 月曜開始
  end

  def index
    @habits = current_user.habits.order(created_at: :desc)
  end

  def new
    @habit = current_user.habits.build
  end

  def show
    @habit = Habit.find_by(id: params[:id])
    @comments = @habit.comments.order(created_at: :desc) # コメント降順
    @week_start = Date.current.beginning_of_week(:monday) # 月曜開始
  end

  def edit; end

  def update
    if @habit.update(habit_params)
      redirect_to habit_path, notice: "習慣を更新しました"
    else
      flash.now[:alert] = "習慣の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @habit = current_user.habits.build(habit_params)
    if @habit.save
      redirect_to dashboard_path, notice: "習慣を作成しました"
    else
      flash.now[:alert] = "習慣の作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.destroy!
    redirect_to habits_path, notice: "習慣を削除しました", status: :see_other
  end

  private

  def habit_params
    params.require(:habit).permit(:title, :frequency, :start_date, :is_public)
  end

  def set_habits
    @habit = current_user.habits.find_by(id: params[:id]) # 他のユーザーがアクセスできないようcurrent_userで取り出す。
  end
end
