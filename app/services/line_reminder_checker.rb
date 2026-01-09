class LineReminderChecker
  def initialize(user, date = Date.current)
    @user = user
    @date = date
  end

  def remind_needed?
    habits = @user.habits

    habits.any? do |habit|
      !checked_today?(habit)
    end
  end

  private

  def checked_today?(habit)
    HabitCheck.exists?(
      user: @user,
      habit: habit,
      checked_on: @date
    )
  end
end
