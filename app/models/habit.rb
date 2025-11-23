class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_checks, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }

  # frequency 頻度enum管理(毎日・週に3回・週に1回)
  enum frequency: { daily: 0, three_times_week: 1, once_a_week: 2 }

  # 特定の習慣を特定のユーザーが特定の日にチェックしたかを返すメソッド
  def checked_on?(user, date)
    habit_checks.exists?(user: user, checked_on: date)
  end

  # ユーザーが習慣を始めて１週間のうちに、どの日が達成(チェック)したのかを取り出すメソッド。pluckで配列で取り出す。
  def checks_for_week(user, week_start)
    habit_checks.where(user: user, checked_on: week_start..(week_start + 6.days)).pluck(:checked_on)
  end
end
