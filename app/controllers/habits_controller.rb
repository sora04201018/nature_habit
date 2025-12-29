class HabitsController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみ
  before_action :set_habits, only: %i[ edit update destroy ]

  # 習慣公開処理
  def public_index
    @habits = Habit.publicly_visible.includes(:user).order(created_at: :desc)
    @week_start = Date.current.beginning_of_week(:monday) # 月曜開始
  end

  def index
    @habits = current_user.habits.includes(:categories).order(created_at: :desc)
  end

  def new
    @habit = current_user.habits.build
    @categories = Category.order(:name)
  end

  def show
    @habit = Habit.find_by(id: params[:id])
    @comments = @habit.comments.order(created_at: :desc) # コメント降順
    @week_start = Date.current.beginning_of_week(:monday) # 月曜開始
  end

  def edit
    @categories = Category.order(:name)
    @category_json = @habit.categories.map { |c| { value: c.name } }.to_json
  end

  def update
    if @habit.update(habit_params.except(:category_names))
      save_categories_from_json(@habit, habit_params[:category_names])
      redirect_to habit_path(@habit), notice: "習慣を更新しました"
    else
      flash.now[:alert] = "習慣の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end


  def create
    @habit = current_user.habits.build(habit_params.except(:category_names))

    if @habit.save
      save_categories_from_json(@habit, habit_params[:category_names])
      redirect_to dashboard_path, notice: "習慣を作成しました"
    else
      @categories = Category.order(:name)
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
    params.require(:habit).permit(:title, :frequency, :start_date, :is_public, :category_names)
  end

  def set_habits
    @habit = current_user.habits.includes(:categories).find_by(id: params[:id]) # 他のユーザーがアクセスできないようcurrent_userで取り出す。
  end

  def save_categories_from_json(habit, json)
    if json.blank?
      habit.categories.clear
      return
    end

    names =
      JSON.parse(json)
          .map { |h| h["value"] }
          .map(&:strip)
          .reject(&:blank?)
          .uniq

    categories = names.map do |name|
      Category.find_or_create_by(name: name)
    end

    habit.categories = categories
  end
end
