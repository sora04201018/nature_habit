class Habit < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }

  # frequency 頻度enum管理(毎日・週に3回・週に1回)
  enum frequency: { daily: 0, three_times_week: 1, once_a_week: 2 }
end
