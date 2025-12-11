class User < ApplicationRecord
  has_many :habits, dependent: :destroy
  has_many :habit_checks, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  # トータルの達成回数を集計（バッジ付与のため）
  def total_habit_checks_count
    habit_checks.count
  end
end
