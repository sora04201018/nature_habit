class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, :threshold, presence: true
  validates :threshold, numericality: { only_integer: true, greater_than_or_equal_to: 1 } # 数字でかつ整数で、1以上の値のみ認める
end
