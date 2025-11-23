class HabitCheck < ApplicationRecord
  belongs_to :user
  belongs_to :habit

  validates :checked_on, presence: true
  validates :habit_id, uniqueness: { scope: [ :user_id, :checked_on ] } # マイグレーション同様の制約。scopeでカラムの組み合わせ指定。
end
