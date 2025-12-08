class UserBadge < ApplicationRecord
  belongs_to :badge
  belongs_to :user

  validates :user_id, uniqueness: { scope: :badge_id } # 一人のユーザーは同じバッジを重複して持てない
end
